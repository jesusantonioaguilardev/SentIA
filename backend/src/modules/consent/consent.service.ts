import { HttpStatus, Injectable } from '@nestjs/common';
import { AppException } from '../../common/errors/app.exception';
import { HashingService } from '../../common/crypto/hashing.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { ConsentDocument } from '../../generated/prisma/client';
import { AuditService } from '../audit/audit.service';
import {
  ConsentDocumentDto,
  ConsentStatusDto,
  RecordConsentDto,
} from './dto/consent.dto';

const DEFAULT_LOCALE = 'es-MX';

/**
 * Consentimiento versionado (docs/09 §1). Cada decisión es una fila nueva
 * (historial completo); la vigente es la más reciente por documento.
 */
@Injectable()
export class ConsentService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly hashing: HashingService,
    private readonly audit: AuditService,
  ) {}

  /** Versión más reciente de cada tipo de documento. */
  async currentDocuments(locale = DEFAULT_LOCALE): Promise<ConsentDocument[]> {
    const documents = await this.prisma.consentDocument.findMany({
      where: { locale },
      orderBy: { publishedAt: 'desc' },
    });
    const latest = new Map<string, ConsentDocument>();
    for (const doc of documents) {
      if (!latest.has(doc.type)) latest.set(doc.type, doc);
    }
    return [...latest.values()];
  }

  async statusFor(subjectId: string): Promise<ConsentStatusDto[]> {
    const documents = await this.currentDocuments();
    const decisions = await this.prisma.userConsent.findMany({
      where: { subjectId, documentId: { in: documents.map((d) => d.id) } },
      orderBy: { grantedAt: 'desc' },
    });
    return documents.map((document) => {
      const latest = decisions.find((d) => d.documentId === document.id);
      return {
        document: toDto(document),
        granted: latest?.granted ?? false,
        decidedAt: latest?.grantedAt.toISOString() ?? null,
      };
    });
  }

  /** true si aceptó la versión vigente de todos los documentos obligatorios. */
  async hasRequiredConsents(subjectId: string): Promise<boolean> {
    const status = await this.statusFor(subjectId);
    return status.filter((s) => s.document.required).every((s) => s.granted);
  }

  async record(
    subjectId: string,
    dto: RecordConsentDto,
    ip?: string,
  ): Promise<void> {
    const current = await this.currentDocuments();
    if (!current.some((d) => d.id === dto.documentId)) {
      throw new AppException(
        'DOCUMENT_NOT_CURRENT',
        'Ese documento no es la versión vigente',
        HttpStatus.CONFLICT,
      );
    }
    const ipHash = this.hashing.hashIp(ip);
    await this.prisma.userConsent.create({
      data: {
        subjectId,
        documentId: dto.documentId,
        granted: dto.granted,
        revokedAt: dto.granted ? null : new Date(),
        appVersion: dto.appVersion,
        ipHash,
      },
    });
    await this.audit.record({
      action: dto.granted ? 'consent.granted' : 'consent.revoked',
      actorSubjectId: subjectId,
      resourceType: 'consent_document',
      resourceId: dto.documentId,
      ipHash,
    });
  }
}

export function toDto(document: ConsentDocument): ConsentDocumentDto {
  return {
    id: document.id,
    type: document.type,
    version: document.version,
    title: document.title,
    content: document.content,
    required: document.required,
    isDraft: document.isDraft,
    publishedAt: document.publishedAt.toISOString(),
  };
}
