import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { configureApp } from '../src/app.setup';
import { PrismaService } from '../src/common/prisma/prisma.service';

describe('GET /v1/health (e2e)', () => {
  let app: INestApplication<App>;
  const queryRaw = jest.fn();

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] })
      .overrideProvider(PrismaService)
      .useValue({ $queryRaw: queryRaw, $disconnect: jest.fn() })
      .compile();

    app = moduleRef.createNestApplication();
    configureApp(app);
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('responde 200 con la base de datos arriba', async () => {
    queryRaw.mockResolvedValueOnce([{ '?column?': 1 }]);

    const res = await request(app.getHttpServer())
      .get('/v1/health')
      .expect(200);

    expect(res.body).toMatchObject({ status: 'ok', database: 'up' });
  });

  it('responde 503 si la base de datos no contesta', async () => {
    queryRaw.mockRejectedValueOnce(new Error('connection refused'));

    const res = await request(app.getHttpServer())
      .get('/v1/health')
      .expect(503);

    expect(res.body).toMatchObject({ status: 'degraded', database: 'down' });
  });

  it('usa el formato de error común en rutas inexistentes', async () => {
    const res = await request(app.getHttpServer())
      .get('/v1/no-existe')
      .expect(404);

    const body = res.body as {
      error: { code: string; message: unknown; traceId: unknown };
    };
    expect(Object.keys(body)).toEqual(['error']);
    expect(body.error.code).toBe('NOT_FOUND');
    expect(typeof body.error.message).toBe('string');
    expect(typeof body.error.traceId).toBe('string');
  });
});
