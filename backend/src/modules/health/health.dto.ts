import { ApiProperty } from '@nestjs/swagger';

export class HealthDto {
  @ApiProperty({ enum: ['ok', 'degraded'] })
  status!: 'ok' | 'degraded';

  @ApiProperty({ enum: ['up', 'down'] })
  database!: 'up' | 'down';

  @ApiProperty({ enum: ['dev', 'staging', 'prod'] })
  environment!: 'dev' | 'staging' | 'prod';

  @ApiProperty({ example: '0.0.1' })
  version!: string;
}
