import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { HashingService } from '../src/common/crypto/hashing.service';
import { Env } from '../src/config/env.schema';
import { AuditService } from '../src/modules/audit/audit.service';

/** ConfigService falso con los valores que necesitan los servicios. */
export function fakeConfig(
  overrides: Partial<Record<keyof Env, unknown>> = {},
): ConfigService<Env, true> {
  const values: Record<string, unknown> = {
    JWT_ACCESS_TTL_SECONDS: 900,
    REFRESH_TTL_DAYS: 30,
    IP_HASH_SALT: 'test-salt-0123456789',
    FIELD_ENCRYPTION_KEY: Buffer.alloc(32, 7).toString('base64'),
    PUBLIC_BASE_URL: 'https://api.test',
    ...overrides,
  };
  return { get: (key: string) => values[key] } as ConfigService<Env, true>;
}

export const testJwt = () =>
  new JwtService({ secret: 'unit-test-secret-unit-test-secret!!' });

export const testHashing = () => new HashingService(fakeConfig());

export function fakeAudit(): AuditService & { record: jest.Mock } {
  return { record: jest.fn().mockResolvedValue(undefined) } as never;
}

/** Ejecuta las operaciones de un `$transaction([...])` simulado. */
export const runTransaction = jest.fn((ops: unknown[]) => Promise.all(ops));
