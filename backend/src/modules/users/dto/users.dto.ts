import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { z } from 'zod';

const emergencyContact = z.object({
  name: z.string().trim().min(1).max(100),
  // Formato libre pero acotado: dígitos, espacios, +, -, paréntesis.
  phone: z
    .string()
    .trim()
    .regex(/^[+\d][\d\s\-()]{6,24}$/),
});

export class EmergencyContactDto {
  @ApiProperty()
  name!: string;

  @ApiProperty({ example: '+52 55 1234 5678' })
  phone!: string;
}

export class ProfileDto {
  @ApiProperty()
  email!: string;

  @ApiProperty()
  birthYear!: number;

  @ApiPropertyOptional({ nullable: true, type: String })
  displayName!: string | null;

  @ApiProperty({ example: 'America/Mexico_City' })
  timezone!: string;

  @ApiPropertyOptional({ nullable: true, type: EmergencyContactDto })
  emergencyContact!: EmergencyContactDto | null;

  @ApiProperty()
  createdAt!: string;
}

export class UpdateProfileDto {
  static schema = z
    .object({
      displayName: z.string().trim().min(1).max(60).optional(),
      timezone: z.string().min(3).max(64).optional(),
      /** Para borrarlo: DELETE /v1/me/emergency-contact. */
      emergencyContact: emergencyContact.optional(),
    })
    .strict();

  @ApiPropertyOptional()
  displayName?: string;

  @ApiPropertyOptional()
  timezone?: string;

  @ApiPropertyOptional({
    type: EmergencyContactDto,
    description:
      'Opcional. La persona debe estar informada de que la registras (docs/02).',
  })
  emergencyContact?: EmergencyContactDto;
}

export class DeleteAccountDto {
  static schema = z.object({ password: z.string().min(1).max(128) });

  @ApiProperty({ description: 'Confirmación con la contraseña actual.' })
  password!: string;
}

export class AccountDeletionRequestDto {
  static schema = z.object({
    email: z
      .email()
      .max(254)
      .transform((v) => v.trim().toLowerCase()),
  });

  @ApiProperty()
  email!: string;
}

export class ConfirmDeletionDto {
  static schema = z.object({ token: z.string().min(20).max(200) });

  @ApiProperty()
  token!: string;
}
