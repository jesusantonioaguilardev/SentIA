import {
  ArgumentMetadata,
  HttpStatus,
  Injectable,
  PipeTransform,
} from '@nestjs/common';
import { ZodType } from 'zod';
import { AppException } from '../errors/app.exception';

/** Un DTO validable declara `static schema` (zod); `@ApiProperty` documenta OpenAPI. */
interface ZodDtoClass {
  schema: ZodType;
}

function hasSchema(metatype: unknown): metatype is ZodDtoClass {
  return (
    typeof metatype === 'function' &&
    'schema' in metatype &&
    (metatype as { schema?: unknown }).schema instanceof ZodType
  );
}

/**
 * Valida cuerpos y query contra el schema zod del DTO. Ante error devuelve
 * VALIDATION_ERROR con los nombres de campo, nunca con los valores enviados
 * (podrían ser contraseñas o datos personales).
 */
@Injectable()
export class ZodValidationPipe implements PipeTransform {
  transform(value: unknown, metadata: ArgumentMetadata): unknown {
    if (!hasSchema(metadata.metatype)) return value;
    if (metadata.type !== 'body' && metadata.type !== 'query') return value;

    const result = metadata.metatype.schema.safeParse(value);
    if (!result.success) {
      const fields = [
        ...new Set(result.error.issues.map((issue) => issue.path.join('.'))),
      ].filter(Boolean);
      throw new AppException(
        'VALIDATION_ERROR',
        'Datos inválidos',
        HttpStatus.BAD_REQUEST,
        fields,
      );
    }
    return result.data;
  }
}
