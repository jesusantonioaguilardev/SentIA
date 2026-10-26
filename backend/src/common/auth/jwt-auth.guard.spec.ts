import { ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { PrismaService } from '../prisma/prisma.service';
import { testJwt } from '../../../test/unit-helpers';
import { AuthenticatedRequest } from './auth.decorators';
import { JwtAuthGuard } from './jwt-auth.guard';

function context(request: Partial<AuthenticatedRequest>): ExecutionContext {
  return {
    getHandler: () => undefined,
    getClass: () => undefined,
    switchToHttp: () => ({ getRequest: () => request }),
  } as unknown as ExecutionContext;
}

function setup(isPublic = false) {
  const reflector = { getAllAndOverride: jest.fn().mockReturnValue(isPublic) };
  const prisma = { user: { findUnique: jest.fn() } };
  const jwt = testJwt();
  const guard = new JwtAuthGuard(
    reflector as unknown as Reflector,
    jwt,
    prisma as unknown as PrismaService,
  );
  return { guard, prisma, jwt };
}

const activeUser = { status: 'active', tokensValidAfter: new Date(0) };

describe('JwtAuthGuard', () => {
  it('deja pasar rutas públicas sin token', async () => {
    const { guard } = setup(true);
    await expect(guard.canActivate(context({ headers: {} }))).resolves.toBe(
      true,
    );
  });

  it('rechaza peticiones sin token (deny-by-default)', async () => {
    const { guard } = setup();
    await expect(
      guard.canActivate(context({ headers: {} })),
    ).rejects.toMatchObject({
      code: 'UNAUTHORIZED',
    });
  });

  it('rechaza tokens mal firmados', async () => {
    const { guard } = setup();
    await expect(
      guard.canActivate(
        context({ headers: { authorization: 'Bearer no.es.jwt' } }),
      ),
    ).rejects.toMatchObject({ code: 'UNAUTHORIZED' });
  });

  it('acepta un token válido y deja el usuario en la petición', async () => {
    const { guard, jwt, prisma } = setup();
    prisma.user.findUnique.mockResolvedValue(activeUser);
    const token = await jwt.signAsync({ sub: 'u1', sid: 's1', role: 'user' });
    const request: Partial<AuthenticatedRequest> = {
      headers: { authorization: `Bearer ${token}` },
    };

    await expect(guard.canActivate(context(request))).resolves.toBe(true);
    expect(request.user).toEqual({
      userId: 'u1',
      subjectId: 's1',
      role: 'user',
    });
  });

  it.each([
    ['la cuenta ya no existe', null],
    ['la cuenta está suspendida', { ...activeUser, status: 'suspended' }],
    [
      'el token es anterior a un logout-all',
      { ...activeUser, tokensValidAfter: new Date(Date.now() + 60_000) },
    ],
  ])('rechaza el token si %s', async (_, user) => {
    const { guard, jwt, prisma } = setup();
    prisma.user.findUnique.mockResolvedValue(user);
    const token = await jwt.signAsync({ sub: 'u1', sid: 's1', role: 'user' });

    await expect(
      guard.canActivate(
        context({ headers: { authorization: `Bearer ${token}` } }),
      ),
    ).rejects.toMatchObject({ code: 'UNAUTHORIZED' });
  });
});
