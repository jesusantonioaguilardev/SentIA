import { z } from 'zod';

/**
 * Variables de entorno validadas al arrancar: si falta o es inválida alguna,
 * la app no levanta (fallar pronto es preferible a fallar con datos reales).
 */
export const envSchema = z.object({
  NODE_ENV: z
    .enum(['development', 'test', 'production'])
    .default('development'),
  APP_ENV: z.enum(['dev', 'staging', 'prod']).default('dev'),
  PORT: z.coerce.number().int().positive().default(3000),
  DATABASE_URL: z.url({ protocol: /^postgres(ql)?$/ }),
  CORS_ORIGINS: z
    .string()
    .default('')
    .transform((value) =>
      value
        .split(',')
        .map((origin) => origin.trim())
        .filter(Boolean),
    ),
  LOG_LEVEL: z
    .enum(['fatal', 'error', 'warn', 'info', 'debug', 'trace'])
    .default('info'),

  /** URL pública del backend: base de los enlaces en correos. */
  PUBLIC_BASE_URL: z.url().default('http://localhost:3000'),

  // ─── Auth (docs/05) ───
  /** Secreto HMAC del access token; mínimo 32 caracteres. */
  JWT_ACCESS_SECRET: z.string().min(32),
  JWT_ACCESS_TTL_SECONDS: z.coerce.number().int().positive().default(900),
  REFRESH_TTL_DAYS: z.coerce.number().int().positive().default(30),
  /** Sal para seudonimizar IPs en auditoría y consentimientos (no se guarda la IP). */
  IP_HASH_SALT: z.string().min(16),

  // ─── Cifrado por campo ───
  /** Llave AES-256 en base64 (32 bytes). TODO(etapa-2): envelope con KMS. */
  FIELD_ENCRYPTION_KEY: z
    .string()
    .refine((value) => Buffer.from(value, 'base64').length === 32, {
      message: 'debe ser base64 de exactamente 32 bytes',
    }),

  // ─── Correo ───
  /** En desarrollo apunta a Mailpit (docker-compose); proveedor de prod [PENDIENTE]. */
  SMTP_URL: z.string().default('smtp://localhost:1025'),
  MAIL_FROM: z.string().default('SentIA <no-reply@sentia.invalid>'),
});

export type Env = z.infer<typeof envSchema>;

export function validateEnv(config: Record<string, unknown>): Env {
  const result = envSchema.safeParse(config);
  if (!result.success) {
    throw new Error(
      `Configuración de entorno inválida:\n${z.prettifyError(result.error)}`,
    );
  }
  return result.data;
}
