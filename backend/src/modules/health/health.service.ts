import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Env } from '../../config/env.schema';
import { PrismaService } from '../../common/prisma/prisma.service';
import { HealthDto } from './health.dto';

@Injectable()
export class HealthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService<Env, true>,
  ) {}

  async check(): Promise<HealthDto> {
    const database = await this.pingDatabase();
    return {
      status: database === 'up' ? 'ok' : 'degraded',
      database,
      environment: this.config.get('APP_ENV', { infer: true }),
      version: process.env.npm_package_version ?? '0.0.1',
    };
  }

  private async pingDatabase(): Promise<'up' | 'down'> {
    try {
      await this.prisma.$queryRaw`SELECT 1`;
      return 'up';
    } catch {
      return 'down';
    }
  }
}
