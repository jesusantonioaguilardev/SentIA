// Se carga antes de importar AppModule: ConfigModule valida el entorno al
// importarse, así que los tests no deben depender de un .env local (CI no lo tiene).
// Valores falsos y evidentes: nunca usar fuera de tests.
process.env.NODE_ENV = 'test';
process.env.DATABASE_URL ??= 'postgresql://test:test@localhost:5432/test';
process.env.JWT_ACCESS_SECRET = 'test-only-jwt-secret-not-for-production-use';
process.env.IP_HASH_SALT = 'test-only-ip-salt';
// 32 bytes en cero, en base64.
process.env.FIELD_ENCRYPTION_KEY =
  'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=';
process.env.PUBLIC_BASE_URL = 'http://localhost:3000';
