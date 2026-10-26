import { createCipheriv, createDecipheriv, randomBytes } from 'node:crypto';
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Env } from '../../config/env.schema';

const ALGORITHM = 'aes-256-gcm';
const VERSION = 'v1';
const IV_BYTES = 12;

/**
 * Cifrado a nivel de campo (docs/05 §Cifrado) para datos sensibles en reposo:
 * contacto de emergencia ahora; mensajes, notas y respuestas de tests después.
 *
 * Formato: `v1:<iv>:<tag>:<datos>` en base64url. El prefijo de versión permite
 * rotar la llave o el algoritmo sin ambigüedad.
 * TODO(etapa-2): envelope encryption con KMS en lugar de una llave en entorno.
 */
@Injectable()
export class FieldCryptoService {
  private readonly key: Buffer;

  constructor(config: ConfigService<Env, true>) {
    const encodedKey: string = config.get('FIELD_ENCRYPTION_KEY', {
      infer: true,
    });
    this.key = Buffer.from(encodedKey, 'base64');
  }

  encrypt(plaintext: string): string {
    const iv = randomBytes(IV_BYTES);
    const cipher = createCipheriv(ALGORITHM, this.key, iv);
    const data = Buffer.concat([
      cipher.update(plaintext, 'utf8'),
      cipher.final(),
    ]);
    const tag = cipher.getAuthTag();
    const encoded = [iv, tag, data].map((part) => part.toString('base64url'));
    return [VERSION, ...encoded].join(':');
  }

  /** Lanza si el valor fue alterado o se cifró con otra llave (GCM autentica). */
  decrypt(payload: string): string {
    const [version, iv, tag, data] = payload.split(':');
    if (version !== VERSION || !iv || !tag || data === undefined) {
      throw new Error('Formato de campo cifrado no reconocido');
    }
    const decipher = createDecipheriv(
      ALGORITHM,
      this.key,
      Buffer.from(iv, 'base64url'),
    );
    decipher.setAuthTag(Buffer.from(tag, 'base64url'));
    return Buffer.concat([
      decipher.update(Buffer.from(data, 'base64url')),
      decipher.final(),
    ]).toString('utf8');
  }

  encryptOptional(value: string | null | undefined): string | null {
    return value ? this.encrypt(value) : null;
  }

  decryptOptional(value: string | null | undefined): string | null {
    return value ? this.decrypt(value) : null;
  }
}
