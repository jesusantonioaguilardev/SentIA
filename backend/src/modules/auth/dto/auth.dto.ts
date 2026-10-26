import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { z } from 'zod';

const email = z
  .email()
  .max(254)
  .transform((value) => value.trim().toLowerCase());

/** Mínimo 12 caracteres (frases de paso); máximo para acotar el costo de argon2. */
const newPassword = z.string().min(12).max(128);

export class RegisterDto {
  static schema = z.object({
    email,
    password: newPassword,
    birthYear: z.number().int().min(1900).max(new Date().getFullYear()),
    /** Autodeclaración explícita de mayoría de edad (docs/12). */
    ageConfirmed: z.literal(true),
  });

  @ApiProperty({ example: 'ana@correo.mx' })
  email!: string;

  @ApiProperty({ minLength: 12, maxLength: 128 })
  password!: string;

  @ApiProperty({ example: 1995 })
  birthYear!: number;

  @ApiProperty({ description: 'El usuario declara ser mayor de 18 años.' })
  ageConfirmed!: boolean;
}

export class LoginDto {
  static schema = z.object({
    email,
    password: z.string().min(1).max(128),
  });

  @ApiProperty({ example: 'ana@correo.mx' })
  email!: string;

  @ApiProperty()
  password!: string;
}

export class RefreshDto {
  static schema = z.object({ refreshToken: z.string().min(20).max(200) });

  @ApiProperty()
  refreshToken!: string;
}

export class ForgotPasswordDto {
  static schema = z.object({ email });

  @ApiProperty({ example: 'ana@correo.mx' })
  email!: string;
}

export class ResetPasswordDto {
  static schema = z.object({
    token: z.string().min(20).max(200),
    password: newPassword,
  });

  @ApiProperty()
  token!: string;

  @ApiProperty({ minLength: 12, maxLength: 128 })
  password!: string;
}

export class TokenPairDto {
  @ApiProperty()
  accessToken!: string;

  @ApiProperty()
  refreshToken!: string;

  @ApiProperty({ description: 'Segundos de vida del access token.' })
  expiresIn!: number;
}

export class MessageDto {
  @ApiProperty()
  message!: string;

  @ApiPropertyOptional()
  detail?: string;
}
