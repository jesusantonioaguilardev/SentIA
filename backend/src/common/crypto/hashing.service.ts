import { createHash, createHmac, randomBytes } from 'node:crypto';
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Env } from '../../config/env.schema';

/** Hashes no reversibles para tokens e IPs: nunca se guarda el valor original. */
@Injectable()
export class HashingService {
  private readonly ipSalt: string;

  constructor(config: ConfigService<Env, true>) {
    this.ipSalt = config.get('IP_HASH_SALT', { infer: true });
  }

  /** Token aleatorio para enviar al cliente (refresh, enlaces por correo). */
  newToken(): string {
    return randomBytes(32).toString('base64url');
  }

  /** Lo que se guarda en BD en lugar del token. */
  hashToken(token: string): string {
    return createHash('sha256').update(token).digest('hex');
  }

  /** IP seudonimizada con sal: permite agrupar eventos sin guardar la IP. */
  hashIp(ip: string | undefined): string | null {
    if (!ip) return null;
    return createHmac('sha256', this.ipSalt)
      .update(ip)
      .digest('hex')
      .slice(0, 32);
  }
}
