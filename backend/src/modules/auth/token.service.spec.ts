import { PrismaService } from '../../common/prisma/prisma.service';
import {
  fakeAudit,
  fakeConfig,
  testHashing,
  testJwt,
} from '../../../test/unit-helpers';
import { TokenService } from './token.service';

const user = { id: 'u1', subjectId: 's1', role: 'user', status: 'active' };

function setup() {
  const prisma = {
    refreshToken: {
      create: jest.fn().mockResolvedValue({}),
      findUnique: jest.fn(),
      updateMany: jest.fn().mockResolvedValue({ count: 1 }),
    },
    user: { update: jest.fn().mockResolvedValue({}) },
    $transaction: jest.fn((ops: unknown[]) => Promise.all(ops)),
  };
  const audit = fakeAudit();
  const jwt = testJwt();
  const hashing = testHashing();
  const service = new TokenService(
    prisma as unknown as PrismaService,
    jwt,
    hashing,
    audit,
    fakeConfig(),
  );
  return { prisma, audit, jwt, hashing, service };
}

function stored(overrides: Record<string, unknown> = {}) {
  return {
    id: 'rt1',
    familyId: 'fam1',
    revokedAt: null,
    rotatedAt: null,
    deviceInfo: 'Android',
    expiresAt: new Date(Date.now() + 60_000),
    user,
    ...overrides,
  };
}

describe('TokenService', () => {
  it('emite un access JWT con sub, sid y rol, y guarda solo el hash del refresh', async () => {
    const { service, prisma, jwt, hashing } = setup();

    const pair = await service.issue(user, 'Android');

    const payload = await jwt.verifyAsync<{
      sub: string;
      sid: string;
      role: string;
    }>(pair.accessToken);
    expect(payload).toMatchObject({ sub: 'u1', sid: 's1', role: 'user' });
    expect(pair.expiresIn).toBe(900);
    const saved = prisma.refreshToken.create.mock.calls[0][0].data;
    expect(saved.tokenHash).toBe(hashing.hashToken(pair.refreshToken));
    expect(saved.tokenHash).not.toBe(pair.refreshToken);
    expect(saved.deviceInfo).toBe('Android');
  });

  it('rota un refresh válido dentro de la misma familia', async () => {
    const { service, prisma } = setup();
    prisma.refreshToken.findUnique.mockResolvedValue(stored());

    const pair = await service.rotate('token-anterior-con-longitud-suficiente');

    expect(pair.refreshToken).toBeDefined();
    expect(prisma.refreshToken.updateMany).toHaveBeenCalledWith({
      where: { id: 'rt1', rotatedAt: null },
      data: { rotatedAt: expect.any(Date) },
    });
    expect(prisma.refreshToken.create.mock.calls[0][0].data.familyId).toBe(
      'fam1',
    );
  });

  it('detecta reuso: revoca la familia, audita y responde REFRESH_REUSED', async () => {
    const { service, prisma, audit } = setup();
    prisma.refreshToken.findUnique.mockResolvedValue(
      stored({ rotatedAt: new Date() }),
    );
    prisma.refreshToken.updateMany
      .mockResolvedValueOnce({ count: 0 }) // ya estaba rotado
      .mockResolvedValueOnce({ count: 3 }); // revocación de la familia

    await expect(service.rotate('robado')).rejects.toMatchObject({
      code: 'REFRESH_REUSED',
    });
    expect(prisma.refreshToken.updateMany).toHaveBeenLastCalledWith({
      where: { familyId: 'fam1', revokedAt: null },
      data: { revokedAt: expect.any(Date) },
    });
    expect(audit.record).toHaveBeenCalledWith(
      expect.objectContaining({ action: 'auth.refresh_reuse_detected' }),
    );
    expect(prisma.refreshToken.create).not.toHaveBeenCalled();
  });

  it.each([
    ['inexistente', null],
    ['revocado', stored({ revokedAt: new Date() })],
    [
      'de una cuenta suspendida',
      stored({ user: { ...user, status: 'suspended' } }),
    ],
  ])('rechaza un refresh %s', async (_, value) => {
    const { service, prisma } = setup();
    prisma.refreshToken.findUnique.mockResolvedValue(value);

    await expect(service.rotate('x')).rejects.toMatchObject({
      code: 'INVALID_TOKEN',
    });
  });

  it('rechaza un refresh expirado', async () => {
    const { service, prisma } = setup();
    prisma.refreshToken.findUnique.mockResolvedValue(
      stored({ expiresAt: new Date(Date.now() - 1000) }),
    );

    await expect(service.rotate('x')).rejects.toMatchObject({
      code: 'INVALID_TOKEN',
    });
    expect(prisma.refreshToken.create).not.toHaveBeenCalled();
  });

  it('revokeByToken revoca la familia y devuelve el usuario', async () => {
    const { service, prisma } = setup();
    prisma.refreshToken.findUnique.mockResolvedValue({
      familyId: 'fam1',
      userId: 'u1',
    });

    await expect(service.revokeByToken('x')).resolves.toBe('u1');
    expect(prisma.refreshToken.updateMany).toHaveBeenCalledWith(
      expect.objectContaining({ where: { familyId: 'fam1', revokedAt: null } }),
    );
  });

  it('revokeByToken con token desconocido no hace nada', async () => {
    const { service, prisma } = setup();
    prisma.refreshToken.findUnique.mockResolvedValue(null);

    await expect(service.revokeByToken('x')).resolves.toBeNull();
    expect(prisma.refreshToken.updateMany).not.toHaveBeenCalled();
  });

  it('revokeAll revoca todos los refresh e invalida los access emitidos', async () => {
    const { service, prisma } = setup();

    await service.revokeAll('u1');

    expect(prisma.refreshToken.updateMany).toHaveBeenCalledWith(
      expect.objectContaining({ where: { userId: 'u1', revokedAt: null } }),
    );
    expect(prisma.user.update).toHaveBeenCalledWith({
      where: { id: 'u1' },
      data: { tokensValidAfter: expect.any(Date) },
    });
  });
});
