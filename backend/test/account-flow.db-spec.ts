import { execSync } from 'node:child_process';
import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { configureApp } from '../src/app.setup';
import { MailMessage, MailService } from '../src/common/mail/mail.service';
import { PrismaService } from '../src/common/prisma/prisma.service';

/**
 * Criterio de salida de Etapa 1 (docs/02) contra PostgreSQL real: registro,
 * consentimiento, perfil, exportación y borrado, todo auditado.
 */
describe('Flujo de cuenta completo (PostgreSQL real)', () => {
  let app: INestApplication<App>;
  let prisma: PrismaService;
  const outbox: MailMessage[] = [];
  const email = `flujo-${Date.now()}@test.invalid`;
  const password = 'una frase de paso muy larga';
  const thisYear = new Date().getFullYear();

  beforeAll(async () => {
    execSync('node dist/database/seed', { stdio: 'ignore' });
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] })
      .overrideProvider(MailService)
      .useValue({
        send: (message: MailMessage) => {
          outbox.push(message);
          return Promise.resolve();
        },
      })
      .compile();
    app = moduleRef.createNestApplication();
    configureApp(app);
    await app.init();
    prisma = app.get(PrismaService);
  });

  afterAll(async () => {
    await app.close();
  });

  const http = () => request(app.getHttpServer());
  const tokenFrom = (message: MailMessage) =>
    /token=([\w-]+)/.exec(message.text)![1];
  const waitForMail = async () => {
    for (let i = 0; i < 50 && outbox.length === 0; i++) {
      await new Promise((r) => setTimeout(r, 50));
    }
    return outbox.shift()!;
  };

  let access: string;
  let refresh: string;
  let subjectId: string;

  it('rechaza el registro de menores de 18', async () => {
    const res = await http()
      .post('/v1/auth/register')
      .send({ email, password, birthYear: thisYear - 16, ageConfirmed: true })
      .expect(403);
    expect(res.body.error.code).toBe('UNDERAGE');
  });

  it('valida el cuerpo sin devolver los valores enviados', async () => {
    const res = await http()
      .post('/v1/auth/register')
      .send({ email: 'no-es-correo', password: 'corta', birthYear: 1990 })
      .expect(400);
    expect(res.body.error.code).toBe('VALIDATION_ERROR');
    expect(res.body.error.fields).toEqual(
      expect.arrayContaining(['email', 'password', 'ageConfirmed']),
    );
    expect(JSON.stringify(res.body)).not.toContain('corta');
  });

  it('registra la cuenta y entrega tokens', async () => {
    const res = await http()
      .post('/v1/auth/register')
      .send({
        email: email.toUpperCase(),
        password,
        birthYear: 1990,
        ageConfirmed: true,
      })
      .expect(201);
    access = res.body.accessToken;
    refresh = res.body.refreshToken;
    const user = await prisma.user.findUniqueOrThrow({ where: { email } });
    subjectId = user.subjectId;
    expect(user.passwordHash).toMatch(/^\$argon2id\$/);
  });

  it('no permite duplicar el correo', async () => {
    const res = await http()
      .post('/v1/auth/register')
      .send({ email, password, birthYear: 1990, ageConfirmed: true })
      .expect(409);
    expect(res.body.error.code).toBe('EMAIL_TAKEN');
  });

  it('exige sesión en rutas privadas', async () => {
    await http().get('/v1/me').expect(401);
  });

  it('acepta los consentimientos obligatorios', async () => {
    const docs = await http().get('/v1/consents/current').expect(200);
    expect(docs.body).toHaveLength(5);
    expect(docs.body.every((d: { isDraft: boolean }) => d.isDraft)).toBe(true);

    for (const doc of docs.body.filter(
      (d: { required: boolean }) => d.required,
    )) {
      await http()
        .post('/v1/consents')
        .set('Authorization', `Bearer ${access}`)
        .send({ documentId: doc.id, granted: true, appVersion: '0.1.0+1' })
        .expect(204);
    }

    const status = await http()
      .get('/v1/me/consents')
      .set('Authorization', `Bearer ${access}`)
      .expect(200);
    const required = status.body.filter(
      (s: { document: { required: boolean } }) => s.document.required,
    );
    expect(required.every((s: { granted: boolean }) => s.granted)).toBe(true);
  });

  it('guarda el contacto de emergencia cifrado', async () => {
    const res = await http()
      .patch('/v1/me')
      .set('Authorization', `Bearer ${access}`)
      .send({
        displayName: 'Ana',
        emergencyContact: { name: 'Luis Pérez', phone: '+52 55 1234 5678' },
      })
      .expect(200);
    expect(res.body.emergencyContact).toEqual({
      name: 'Luis Pérez',
      phone: '+52 55 1234 5678',
    });

    const profile = await prisma.userProfile.findFirstOrThrow({
      where: { user: { email } },
    });
    expect(profile.emergencyContactNameEnc).toMatch(/^v1:/);
    expect(profile.emergencyContactNameEnc).not.toContain('Luis');
  });

  it('exporta los datos de la persona', async () => {
    const res = await http()
      .get('/v1/me/export')
      .set('Authorization', `Bearer ${access}`)
      .expect(200);
    expect(res.body.profile.email).toBe(email);
    expect(res.body.consents.length).toBeGreaterThanOrEqual(4);
  });

  it('rota el refresh y detecta su reuso', async () => {
    const rotated = await http()
      .post('/v1/auth/refresh')
      .send({ refreshToken: refresh })
      .expect(200);

    const reuse = await http()
      .post('/v1/auth/refresh')
      .send({ refreshToken: refresh })
      .expect(401);
    expect(reuse.body.error.code).toBe('REFRESH_REUSED');

    // La familia completa quedó revocada, incluido el token recién emitido.
    await http()
      .post('/v1/auth/refresh')
      .send({ refreshToken: rotated.body.refreshToken })
      .expect(401);
  });

  it('restablece la contraseña por correo y cierra todas las sesiones', async () => {
    const login = await http()
      .post('/v1/auth/login')
      .send({ email, password })
      .expect(200);
    access = login.body.accessToken;

    await http().post('/v1/auth/password/forgot').send({ email }).expect(204);
    const mail = await waitForMail();
    expect(mail.text).not.toContain(password);

    // Página web del enlace.
    const page = await http()
      .get(`/restablecer-contrasena?token=${tokenFrom(mail)}`)
      .expect(200);
    expect(page.text).toContain('nueva contraseña');

    await http()
      .post('/v1/auth/password/reset')
      .send({ token: tokenFrom(mail), password: 'otra frase de paso nueva' })
      .expect(204);

    // El access token anterior ya no sirve; la contraseña vieja tampoco.
    await http()
      .get('/v1/me')
      .set('Authorization', `Bearer ${access}`)
      .expect(401);
    await http().post('/v1/auth/login').send({ email, password }).expect(401);

    const fresh = await http()
      .post('/v1/auth/login')
      .send({ email, password: 'otra frase de paso nueva' })
      .expect(200);
    access = fresh.body.accessToken;
  });

  it('borra la cuenta y conserva solo evidencia seudonimizada', async () => {
    await http()
      .delete('/v1/me')
      .set('Authorization', `Bearer ${access}`)
      .send({ password: 'contraseña equivocada' })
      .expect(401);

    await http()
      .delete('/v1/me')
      .set('Authorization', `Bearer ${access}`)
      .send({ password: 'otra frase de paso nueva' })
      .expect(204);

    expect(await prisma.user.count({ where: { email } })).toBe(0);
    expect(
      await prisma.userConsent.count({ where: { subjectId } }),
    ).toBeGreaterThan(0);

    const actions = (
      await prisma.auditLog.findMany({ where: { actorSubjectId: subjectId } })
    ).map((a) => a.action);
    expect(actions).toEqual(
      expect.arrayContaining([
        'auth.register',
        'consent.granted',
        'user.profile_updated',
        'user.data_exported',
        'auth.refresh_reuse_detected',
        'auth.password_reset',
        'user.deleted',
      ]),
    );
    await http()
      .get('/v1/me')
      .set('Authorization', `Bearer ${access}`)
      .expect(401);
  });

  it('permite borrar una cuenta desde la web con confirmación por correo', async () => {
    const webEmail = `web-${Date.now()}@test.invalid`;
    await http()
      .post('/v1/auth/register')
      .send({ email: webEmail, password, birthYear: 1985, ageConfirmed: true })
      .expect(201);

    await http().get('/eliminar-cuenta').expect(200);
    await http()
      .post('/eliminar-cuenta')
      .type('form')
      .send({ email: webEmail })
      .expect(200);
    const mail = await waitForMail();

    const confirm = await http()
      .post('/eliminar-cuenta/confirmar')
      .type('form')
      .send({ token: tokenFrom(mail) })
      .expect(200);
    expect(confirm.text).toContain('Cuenta eliminada');
    expect(await prisma.user.count({ where: { email: webEmail } })).toBe(0);
  });

  it('expone los recursos de ayuda verificados sin sesión', async () => {
    const res = await http().get('/v1/safety/resources?country=MX').expect(200);
    expect(res.body.length).toBeGreaterThan(0);
    expect(res.body[0].verifiedSourceUrl).toMatch(/^https:\/\/www\.gob\.mx\//);
  });
});
