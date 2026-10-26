import { HttpStatus, Injectable } from '@nestjs/common';
import * as argon2 from 'argon2';
import { AppException } from '../../common/errors/app.exception';
import { FieldCryptoService } from '../../common/crypto/field-crypto.service';
import { PrismaService } from '../../common/prisma/prisma.service';
import { AuditService } from '../audit/audit.service';
import { ProfileDto, UpdateProfileDto } from './dto/users.dto';

@Injectable()
export class UsersService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly crypto: FieldCryptoService,
    private readonly audit: AuditService,
  ) {}

  async getProfile(userId: string): Promise<ProfileDto> {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      include: { profile: true },
    });
    const name = this.crypto.decryptOptional(
      user.profile?.emergencyContactNameEnc,
    );
    const phone = this.crypto.decryptOptional(
      user.profile?.emergencyContactPhoneEnc,
    );
    return {
      email: user.email,
      birthYear: user.birthYear,
      displayName: user.profile?.displayName ?? null,
      timezone: user.profile?.timezone ?? 'America/Mexico_City',
      emergencyContact: name && phone ? { name, phone } : null,
      createdAt: user.createdAt.toISOString(),
    };
  }

  async updateProfile(
    userId: string,
    subjectId: string,
    dto: UpdateProfileDto,
  ): Promise<ProfileDto> {
    const contact = dto.emergencyContact;
    const data = {
      displayName: dto.displayName,
      timezone: dto.timezone,
      ...(contact === undefined
        ? {}
        : {
            emergencyContactNameEnc: this.crypto.encrypt(contact.name),
            emergencyContactPhoneEnc: this.crypto.encrypt(contact.phone),
          }),
    };
    await this.prisma.userProfile.upsert({
      where: { userId },
      update: data,
      create: { userId, ...data },
    });
    await this.audit.record({
      action: 'user.profile_updated',
      actorSubjectId: subjectId,
      resourceType: 'user_profile',
    });
    return this.getProfile(userId);
  }

  async clearEmergencyContact(
    userId: string,
    subjectId: string,
  ): Promise<void> {
    await this.prisma.userProfile.update({
      where: { userId },
      data: { emergencyContactNameEnc: null, emergencyContactPhoneEnc: null },
    });
    await this.audit.record({
      action: 'user.profile_updated',
      actorSubjectId: subjectId,
      resourceType: 'emergency_contact',
    });
  }

  /**
   * Derecho de acceso/portabilidad (ARCO, docs/09): todo lo que guardamos de
   * la persona, descifrado y legible. Etapa 2 agregará conversaciones y ánimo.
   */
  async exportData(userId: string, subjectId: string): Promise<object> {
    const [profile, consents, sessions, audit] = await Promise.all([
      this.getProfile(userId),
      this.prisma.userConsent.findMany({
        where: { subjectId },
        include: { document: { select: { type: true, version: true } } },
        orderBy: { grantedAt: 'asc' },
      }),
      this.prisma.refreshToken.findMany({
        where: { userId, revokedAt: null, rotatedAt: null },
        select: { deviceInfo: true, createdAt: true, expiresAt: true },
      }),
      this.prisma.auditLog.findMany({
        where: { actorSubjectId: subjectId },
        select: { action: true, resourceType: true, at: true },
        orderBy: { at: 'asc' },
      }),
    ]);

    await this.prisma.dataRequest.create({
      data: {
        subjectId,
        type: 'export',
        status: 'completed',
        resolvedAt: new Date(),
      },
    });
    await this.audit.record({
      action: 'user.data_exported',
      actorSubjectId: subjectId,
      resourceType: 'user',
    });

    return {
      exportedAt: new Date().toISOString(),
      format: 'sentia-export/1',
      profile,
      consents: consents.map((c) => ({
        document: c.document.type,
        version: c.document.version,
        granted: c.granted,
        at: c.grantedAt.toISOString(),
      })),
      activeSessions: sessions.map((s) => ({
        device: s.deviceInfo,
        since: s.createdAt.toISOString(),
        expires: s.expiresAt.toISOString(),
      })),
      activity: audit.map((a) => ({
        action: a.action,
        resource: a.resourceType,
        at: a.at.toISOString(),
      })),
    };
  }

  /** Borrado desde la app: exige la contraseña actual como confirmación. */
  async deleteWithPassword(
    userId: string,
    subjectId: string,
    password: string,
  ): Promise<void> {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      select: { passwordHash: true },
    });
    const valid = await argon2
      .verify(user.passwordHash, password)
      .catch(() => false);
    if (!valid) {
      throw new AppException(
        'INVALID_CREDENTIALS',
        'La contraseña no es correcta',
        HttpStatus.UNAUTHORIZED,
      );
    }
    await this.deleteAccount(userId, subjectId, 'app');
  }

  /**
   * Borrado inmediato (ADR-0007): elimina cuenta, perfil, sesiones y tokens
   * (cascada). Consentimientos y auditoría quedan ligados solo al seudónimo.
   */
  async deleteAccount(
    userId: string,
    subjectId: string,
    channel: 'app' | 'web',
  ): Promise<void> {
    await this.prisma.$transaction([
      this.prisma.dataRequest.create({
        data: {
          subjectId,
          type: 'cancellation',
          status: 'completed',
          resolvedAt: new Date(),
        },
      }),
      this.prisma.user.delete({ where: { id: userId } }),
    ]);
    await this.audit.record({
      action: 'user.deleted',
      actorSubjectId: subjectId,
      resourceType: 'user',
      reason: `solicitado desde ${channel}`,
    });
  }
}
