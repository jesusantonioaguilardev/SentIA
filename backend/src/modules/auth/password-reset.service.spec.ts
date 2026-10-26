import * as argon2 from 'argon2';
import { MailService } from '../../common/mail/mail.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { fakeAudit, fakeConfig, testHashing } from '../../../test/unit-helpers';
import { OneTimeTokenService } from './one-time-token.service';
import { PasswordResetService } from './password-reset.service';
import { TokenService } from './token.service';

function setup() {
  const prisma = {
    user: { findUnique: jest.fn(), update: jest.fn() },
    oneTimeToken: {
      updateMany: jest.fn().mockResolvedValue({ count: 1 }),
      create: jest.fn().mockResolvedValue({}),
      findUnique: jest.fn(),
    },
    $transaction: jest.fn((ops: unknown[]) => Promise.all(ops)),
  };
  const hashing = testHashing();
  const oneTime = new OneTimeTokenService(
    prisma as unknown as PrismaService,
    hashing,
  );
  const tokens = { revokeAll: jest.fn().mockResolvedValue(undefined) };
  const mail = { send: jest.fn().mockResolvedValue(undefined) };
  const audit = fakeAudit();
  const service = new PasswordResetService(
    prisma as unknown as PrismaService,
    oneTime,
    tokens as unknown as TokenService,
    mail as unknown as MailService,
    hashing,
    audit,
    fakeConfig(),
  );
  return { prisma, hashing, oneTime, tokens, mail, audit, service };
}

describe('PasswordResetService', () => {
  it('envía un enlace de un solo uso y guarda solo su hash', async () => {
    const { service, prisma, mail, hashing } = setup();
    prisma.user.findUnique.mockResolvedValue({
      id: 'u1',
      subjectId: 's1',
      status: 'active',
    });

    await service.request('ana@correo.mx');

    const { text, to } = mail.send.mock.calls[0][0];
    expect(to).toBe('ana@correo.mx');
    const token = /token=([\w-]+)/.exec(text)![1];
    expect(text).toContain('https://api.test/restablecer-contrasena?token=');
    const saved = prisma.oneTimeToken.create.mock.calls[0][0].data;
    expect(saved.tokenHash).toBe(hashing.hashToken(token));
    expect(saved.purpose).toBe('password_reset');
  });

  it('no envía nada si la cuenta no existe (sin revelarlo)', async () => {
    const { service, prisma, mail } = setup();
    prisma.user.findUnique.mockResolvedValue(null);

    await expect(service.request('nadie@correo.mx')).resolves.toBeUndefined();
    expect(mail.send).not.toHaveBeenCalled();
  });

  it('restablece con un token válido, cierra todas las sesiones y audita', async () => {
    const { service, prisma, tokens, audit, hashing } = setup();
    prisma.oneTimeToken.findUnique.mockResolvedValue({
      id: 't1',
      userId: 'u1',
      purpose: 'password_reset',
      expiresAt: new Date(Date.now() + 60_000),
    });
    prisma.user.update.mockResolvedValue({ subjectId: 's1' });

    await service.reset(hashing.newToken(), 'nueva frase de paso segura');

    const data = prisma.user.update.mock.calls[0][0].data;
    expect(
      await argon2.verify(data.passwordHash, 'nueva frase de paso segura'),
    ).toBe(true);
    expect(tokens.revokeAll).toHaveBeenCalledWith('u1');
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({ action: 'auth.password_reset' }),
    );
  });

  it.each([
    ['inexistente', null],
    [
      'expirado',
      {
        id: 't1',
        userId: 'u1',
        purpose: 'password_reset',
        expiresAt: new Date(0),
      },
    ],
    [
      'de otro propósito',
      {
        id: 't1',
        userId: 'u1',
        purpose: 'account_deletion',
        expiresAt: new Date(Date.now() + 60_000),
      },
    ],
  ])('rechaza un token %s', async (_, value) => {
    const { service, prisma } = setup();
    prisma.oneTimeToken.findUnique.mockResolvedValue(value);

    await expect(
      service.reset('x', 'nueva frase de paso segura'),
    ).rejects.toMatchObject({
      code: 'INVALID_TOKEN',
    });
    expect(prisma.user.update).not.toHaveBeenCalled();
  });

  it('rechaza un token ya usado', async () => {
    const { service, prisma } = setup();
    prisma.oneTimeToken.findUnique.mockResolvedValue({
      id: 't1',
      userId: 'u1',
      purpose: 'password_reset',
      expiresAt: new Date(Date.now() + 60_000),
    });
    prisma.oneTimeToken.updateMany.mockResolvedValue({ count: 0 });

    await expect(
      service.reset('x', 'nueva frase de paso segura'),
    ).rejects.toMatchObject({
      code: 'INVALID_TOKEN',
    });
  });
});
