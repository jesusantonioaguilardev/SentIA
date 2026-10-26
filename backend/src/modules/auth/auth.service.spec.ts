import * as argon2 from 'argon2';
import { PrismaService } from '../../common/prisma/prisma.service';
import { Prisma } from '../../generated/prisma/client';
import { fakeAudit, testHashing } from '../../../test/unit-helpers';
import { ARGON2_OPTIONS, AuthService, MIN_AGE } from './auth.service';
import { TokenService } from './token.service';

const pair = { accessToken: 'a', refreshToken: 'r', expiresIn: 900 };
const thisYear = new Date().getFullYear();

function setup() {
  const prisma = {
    user: { create: jest.fn(), findUnique: jest.fn() },
    auditLog: { count: jest.fn().mockResolvedValue(0) },
  };
  const tokens = {
    issue: jest.fn().mockResolvedValue(pair),
    revokeByToken: jest.fn(),
    revokeAll: jest.fn().mockResolvedValue(undefined),
  };
  const audit = fakeAudit();
  const service = new AuthService(
    prisma as unknown as PrismaService,
    tokens as unknown as TokenService,
    testHashing(),
    audit,
  );
  return { prisma, tokens, audit, service };
}

const registration = {
  email: 'ana@correo.mx',
  password: 'una frase de paso larga',
  birthYear: thisYear - 30,
  ageConfirmed: true as const,
};

describe('AuthService.register', () => {
  it('crea la cuenta con argon2id, la audita y emite tokens', async () => {
    const { service, prisma, tokens, audit } = setup();
    prisma.user.create.mockResolvedValue({
      id: 'u1',
      subjectId: 's1',
      role: 'user',
    });

    await expect(
      service.register(registration, { ip: '1.2.3.4', userAgent: 'Pixel' }),
    ).resolves.toEqual(pair);

    const data = prisma.user.create.mock.calls[0][0].data;
    expect(data.passwordHash).toMatch(/^\$argon2id\$/);
    expect(await argon2.verify(data.passwordHash, registration.password)).toBe(
      true,
    );
    expect(data.profile).toEqual({ create: {} });
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({
        action: 'auth.register',
        actorSubjectId: 's1',
      }),
    );
    expect(audit.record.mock.calls[0][0].ipHash).not.toContain('1.2.3.4');
    expect(tokens.issue).toHaveBeenCalledWith(
      { id: 'u1', subjectId: 's1', role: 'user' },
      'Pixel',
    );
  });

  it(`rechaza a menores de ${MIN_AGE} sin crear la cuenta`, async () => {
    const { service, prisma } = setup();

    await expect(
      service.register({ ...registration, birthYear: thisYear - 17 }, {}),
    ).rejects.toMatchObject({ code: 'UNDERAGE' });
    expect(prisma.user.create).not.toHaveBeenCalled();
  });

  it('responde EMAIL_TAKEN si el correo ya existe', async () => {
    const { service, prisma } = setup();
    prisma.user.create.mockRejectedValue(
      new Prisma.PrismaClientKnownRequestError('duplicado', {
        code: 'P2002',
        clientVersion: 'test',
      }),
    );

    await expect(service.register(registration, {})).rejects.toMatchObject({
      code: 'EMAIL_TAKEN',
    });
  });

  it('propaga errores inesperados', async () => {
    const { service, prisma } = setup();
    prisma.user.create.mockRejectedValue(new Error('BD caída'));

    await expect(service.register(registration, {})).rejects.toThrow(
      'BD caída',
    );
  });
});

describe('AuthService.login', () => {
  let passwordHash: string;
  beforeAll(async () => {
    passwordHash = await argon2.hash('contraseña correcta', ARGON2_OPTIONS);
  });

  const account = () => ({
    id: 'u1',
    subjectId: 's1',
    role: 'user',
    status: 'active',
    passwordHash,
  });

  it('con credenciales correctas audita y emite tokens', async () => {
    const { service, prisma, audit, tokens } = setup();
    prisma.user.findUnique.mockResolvedValue(account());

    await expect(
      service.login(
        { email: 'ana@correo.mx', password: 'contraseña correcta' },
        {},
      ),
    ).resolves.toEqual(pair);
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({ action: 'auth.login' }),
    );
    expect(tokens.issue).toHaveBeenCalled();
  });

  it('con contraseña incorrecta responde INVALID_CREDENTIALS y audita el fallo', async () => {
    const { service, prisma, audit, tokens } = setup();
    prisma.user.findUnique.mockResolvedValue(account());

    await expect(
      service.login({ email: 'ana@correo.mx', password: 'otra' }, {}),
    ).rejects.toMatchObject({ code: 'INVALID_CREDENTIALS' });
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({
        action: 'auth.login_failed',
        actorSubjectId: 's1',
      }),
    );
    expect(tokens.issue).not.toHaveBeenCalled();
  });

  it('con correo inexistente responde igual que con contraseña incorrecta', async () => {
    const { service, prisma, audit } = setup();
    prisma.user.findUnique.mockResolvedValue(null);

    await expect(
      service.login({ email: 'nadie@correo.mx', password: 'x' }, {}),
    ).rejects.toMatchObject({ code: 'INVALID_CREDENTIALS' });
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({
        action: 'auth.login_failed',
        actorSubjectId: null,
      }),
    );
  });

  it('rechaza cuentas suspendidas aunque la contraseña sea correcta', async () => {
    const { service, prisma } = setup();
    prisma.user.findUnique.mockResolvedValue({
      ...account(),
      status: 'suspended',
    });

    await expect(
      service.login(
        { email: 'ana@correo.mx', password: 'contraseña correcta' },
        {},
      ),
    ).rejects.toMatchObject({ code: 'INVALID_CREDENTIALS' });
  });

  it('bloquea temporalmente tras demasiados fallos', async () => {
    const { service, prisma, tokens } = setup();
    prisma.user.findUnique.mockResolvedValue(account());
    prisma.auditLog.count.mockResolvedValue(10);

    await expect(
      service.login(
        { email: 'ana@correo.mx', password: 'contraseña correcta' },
        {},
      ),
    ).rejects.toMatchObject({ code: 'ACCOUNT_LOCKED' });
    expect(tokens.issue).not.toHaveBeenCalled();
  });
});

describe('AuthService logout', () => {
  it('logout revoca la familia y audita', async () => {
    const { service, prisma, tokens, audit } = setup();
    tokens.revokeByToken.mockResolvedValue('u1');
    prisma.user.findUnique.mockResolvedValue({ subjectId: 's1' });

    await service.logout('refresh');

    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({ action: 'auth.logout', actorSubjectId: 's1' }),
    );
  });

  it('logout con token desconocido no audita', async () => {
    const { service, tokens, audit } = setup();
    tokens.revokeByToken.mockResolvedValue(null);

    await service.logout('refresh');

    expect(audit.record).not.toHaveBeenCalled();
  });

  it('logoutAll revoca todas las sesiones y audita', async () => {
    const { service, tokens, audit } = setup();

    await service.logoutAll('u1', 's1');

    expect(tokens.revokeAll).toHaveBeenCalledWith('u1');
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({ action: 'auth.logout_all' }),
    );
  });
});
