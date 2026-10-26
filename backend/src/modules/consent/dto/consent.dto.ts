import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { z } from 'zod';

export const CONSENT_TYPES = [
  'privacy_notice',
  'terms',
  'sensitive_data',
  'ai_disclaimer',
  'research',
] as const;
export type ConsentType = (typeof CONSENT_TYPES)[number];

export class ConsentDocumentDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: CONSENT_TYPES })
  type!: ConsentType;

  @ApiProperty({ example: '0.1-borrador' })
  version!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty({ description: 'Markdown.' })
  content!: string;

  @ApiProperty({ description: 'Debe aceptarse para usar la app.' })
  required!: boolean;

  @ApiProperty({
    description:
      'Texto sin revisión legal: la app debe mostrarlo como borrador.',
  })
  isDraft!: boolean;

  @ApiProperty()
  publishedAt!: string;
}

export class ConsentStatusDto {
  @ApiProperty({ type: ConsentDocumentDto })
  document!: ConsentDocumentDto;

  @ApiProperty({
    description: 'Decisión vigente del usuario sobre esta versión.',
  })
  granted!: boolean;

  @ApiPropertyOptional({ nullable: true, type: String })
  decidedAt!: string | null;
}

export class RecordConsentDto {
  static schema = z.object({
    documentId: z.uuid(),
    granted: z.boolean(),
    appVersion: z.string().max(32).optional(),
  });

  @ApiProperty()
  documentId!: string;

  @ApiProperty({ description: 'true = acepta, false = revoca.' })
  granted!: boolean;

  @ApiPropertyOptional({ example: '0.1.0+1' })
  appVersion?: string;
}
