import { execSync } from 'node:child_process';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';

// Pruebas contra PostgreSQL real (servicio en CI; local: npm run db:up).
// Requieren la migración aplicada (npm run db:migrate) y DATABASE_URL real.
describe('Base de datos (PostgreSQL real)', () => {
  let prisma: PrismaClient;

  beforeAll(() => {
    prisma = new PrismaClient({
      adapter: new PrismaPg({ connectionString: process.env.DATABASE_URL! }),
    });
  });

  afterAll(async () => {
    await prisma.$disconnect();
  });

  it('audit_log acepta INSERT pero rechaza UPDATE y DELETE', async () => {
    const entry = await prisma.auditLog.create({
      data: {
        action: 'test.append_only',
        actorRole: 'system',
        resourceType: 'test',
      },
    });

    await expect(
      prisma.auditLog.update({
        where: { id: entry.id },
        data: { action: 'alterado' },
      }),
    ).rejects.toThrow(/append-only/);
    await expect(
      prisma.auditLog.delete({ where: { id: entry.id } }),
    ).rejects.toThrow(/append-only/);
  });

  it('el seed es idempotente y deja documentos borrador y recursos verificados', async () => {
    execSync('node dist/database/seed', { stdio: 'ignore' });
    execSync('node dist/database/seed', { stdio: 'ignore' });

    const documents = await prisma.consentDocument.findMany();
    expect(documents).toHaveLength(5);
    expect(documents.every((d) => d.isDraft)).toBe(true);

    const resources = await prisma.safetyResource.findMany({
      where: { countryCode: 'MX' },
    });
    expect(resources.length).toBeGreaterThan(0);
    for (const r of resources) {
      expect(r.verifiedSourceUrl).toMatch(/^https:\/\/www\.gob\.mx\//);
      expect(r.clinicalApproval).toBe('pending');
    }
  });

  it('borrar un usuario conserva sus consentimientos por seudónimo', async () => {
    const document = await prisma.consentDocument.findFirstOrThrow({
      where: { type: 'terms' },
    });
    const user = await prisma.user.create({
      data: {
        email: `borrado-${Date.now()}@test.invalid`,
        passwordHash: 'x',
        birthYear: 1990,
        profile: { create: {} },
      },
    });
    await prisma.userConsent.create({
      data: {
        subjectId: user.subjectId,
        documentId: document.id,
        granted: true,
      },
    });

    await prisma.user.delete({ where: { id: user.id } });

    expect(await prisma.userProfile.count({ where: { userId: user.id } })).toBe(
      0,
    );
    expect(
      await prisma.userConsent.count({ where: { subjectId: user.subjectId } }),
    ).toBe(1);
  });
});
