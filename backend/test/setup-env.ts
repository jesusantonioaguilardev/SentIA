// Se carga antes de importar AppModule: ConfigModule valida el entorno al
// importarse, así que los tests no deben depender de un .env local (CI no lo tiene).
// Los tests e2e sustituyen PrismaService; esta URL nunca se usa para conectar.
process.env.NODE_ENV = 'test';
process.env.DATABASE_URL ??= 'postgresql://test:test@localhost:5432/test';
