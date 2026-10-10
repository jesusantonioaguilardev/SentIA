import { validateEnv } from './env.schema';

describe('validateEnv', () => {
  const base = { DATABASE_URL: 'postgresql://u:p@localhost:5432/db' };

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

  it('rechaza una URL que no es de PostgreSQL', () => {
    expect(() => validateEnv({ DATABASE_URL: 'mysql://u:p@h/db' })).toThrow();
  });
});
