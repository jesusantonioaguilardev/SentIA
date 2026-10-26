import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Post,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNoContentResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import type { AuthUser, RequestMeta } from '../../common/auth/auth.decorators';
import {
  CurrentUser,
  Public,
  ReqMeta,
} from '../../common/auth/auth.decorators';
import { ConsentService, toDto } from './consent.service';
import {
  ConsentDocumentDto,
  ConsentStatusDto,
  RecordConsentDto,
} from './dto/consent.dto';

@ApiTags('consents')
@Controller()
export class ConsentController {
  constructor(private readonly consents: ConsentService) {}

  /** Documentos vigentes; públicos para poder leerlos antes de registrarse. */
  @Public()
  @Get('consents/current')
  @ApiOkResponse({ type: [ConsentDocumentDto] })
  async current(): Promise<ConsentDocumentDto[]> {
    return (await this.consents.currentDocuments()).map(toDto);
  }

  @ApiBearerAuth()
  @Get('me/consents')
  @ApiOkResponse({ type: [ConsentStatusDto] })
  mine(@CurrentUser() user: AuthUser): Promise<ConsentStatusDto[]> {
    return this.consents.statusFor(user.subjectId);
  }

  @ApiBearerAuth()
  @Post('consents')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse()
  record(
    @CurrentUser() user: AuthUser,
    @Body() dto: RecordConsentDto,
    @ReqMeta() meta: RequestMeta,
  ): Promise<void> {
    return this.consents.record(user.subjectId, dto, meta.ip);
  }
}
