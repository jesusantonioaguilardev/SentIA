import { validateEnv } from './env.schema';

describe('validateEnv', () => {
  const base = {
    DATABASE_URL: 'postgresql://u:p@localhost:5432/db',
    JWT_ACCESS_SECRET: 'x'.repeat(32),
    IP_HASH_SALT: 'y'.repeat(16),
    FIELD_ENCRYPTION_KEY: Buffer.alloc(32).toString('base64'),
  };

  it('aplica valores por defecto', () => {
    expect(validateEnv(base)).toMatchObject({
      NODE_ENV: 'development',
      APP_ENV: 'dev',
      PORT: 3000,
      CORS_ORIGINS: [],
    });
  });

  it('separa CORS_ORIGINS por comas', () => {
    const env = validateEnv({
      ...base,
      CORS_ORIGINS: 'https://a.mx, https://b.mx',
    });
    expect(env.CORS_ORIGINS).toEqual(['https://a.mx', 'https://b.mx']);
  });

  it('falla sin DATABASE_URL', () => {
    expect(() => validateEnv({})).toThrow(/DATABASE_URL/);
  });

  it('rechaza una llave de cifrado que no mide 32 bytes', () => {
    expect(() =>
      validateEnv({
        ...base,
        FIELD_ENCRYPTION_KEY: Buffer.alloc(16).toString('base64'),
      }),
    ).toThrow(/FIELD_ENCRYPTION_KEY/);
  });

  it('rechaza una URL que no es de PostgreSQL', () => {
    expect(() =>
      validateEnv({ ...base, DATABASE_URL: 'mysql://u:p@h/db' }),
    ).toThrow();
  });
});
