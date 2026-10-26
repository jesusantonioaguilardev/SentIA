import { Controller, Get, Injectable, Module, Query } from '@nestjs/common';
import {
  ApiOkResponse,
  ApiProperty,
  ApiPropertyOptional,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { Public } from '../../common/auth/auth.decorators';
import { PrismaService } from '../../common/prisma/prisma.service';

export class SafetyResourceDto {
  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  description!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    type: String,
    description: 'Número marcable, sin espacios.',
  })
  phone!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  sms!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  url!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  hours!: string | null;

  @ApiProperty({ description: 'Página oficial donde se verificó.' })
  verifiedSourceUrl!: string;

  @ApiProperty()
  verifiedAt!: string;

  @ApiProperty({ enum: ['pending', 'approved'] })
  clinicalApproval!: 'pending' | 'approved';
}

/** Recursos de ayuda en crisis (docs/08). Nunca se escriben a mano en el código. */
@Injectable()
export class SafetyService {
  constructor(private readonly prisma: PrismaService) {}

  async resources(countryCode: string): Promise<SafetyResourceDto[]> {
    const rows = await this.prisma.safetyResource.findMany({
      where: { countryCode, active: true },
      orderBy: { sortOrder: 'asc' },
    });
    return rows.map((r) => ({
      name: r.name,
      description: r.description,
      phone: r.phone,
      sms: r.sms,
      url: r.url,
      hours: r.hours,
      verifiedSourceUrl: r.verifiedSourceUrl,
      verifiedAt: r.verifiedAt.toISOString(),
      clinicalApproval: r.clinicalApproval,
    }));
  }
}

@ApiTags('safety')
@Controller('safety')
export class SafetyController {
  constructor(private readonly safety: SafetyService) {}

  /** Público: debe funcionar aunque la sesión haya expirado. */
  @Public()
  @Get('resources')
  @ApiQuery({ name: 'country', required: false, example: 'MX' })
  @ApiOkResponse({ type: [SafetyResourceDto] })
  resources(@Query('country') country?: string): Promise<SafetyResourceDto[]> {
    const code = /^[A-Za-z]{2}$/.test(country ?? '')
      ? country!.toUpperCase()
      : 'MX';
    return this.safety.resources(code);
  }
}

@Module({
  controllers: [SafetyController],
  providers: [SafetyService],
})
export class SafetyModule {}
