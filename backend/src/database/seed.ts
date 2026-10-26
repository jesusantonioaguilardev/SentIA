import { createHash } from 'node:crypto';
import { PrismaPg } from '@prisma/adapter-pg';
import {
  ClinicalApproval,
  ConsentDocumentType,
  PrismaClient,
} from '../generated/prisma/client';
import consentData from './seed-data/consent-documents.json';
import safetyData from './seed-data/safety-resources.mx.json';

/**
 * Datos base: documentos de consentimiento (borradores) y recursos de ayuda.
 * Idempotente: se puede correr varias veces. Uso: `npm run db:seed`.
 * Una versión de documento ya publicada nunca se sobrescribe.
 */
async function main(): Promise<void> {
  const url = process.env.DATABASE_URL;
  if (!url) throw new Error('Falta DATABASE_URL');
  const prisma = new PrismaClient({
    adapter: new PrismaPg({ connectionString: url }),
  });

  try {
    for (const doc of consentData.documents) {
      await prisma.consentDocument.upsert({
        where: {
          type_version_locale: {
            type: doc.type as ConsentDocumentType,
            version: consentData.version,
            locale: consentData.locale,
          },
        },
        update: {},
        create: {
          type: doc.type as ConsentDocumentType,
          version: consentData.version,
          locale: consentData.locale,
          title: doc.title,
          content: doc.content,
          contentHash: createHash('sha256').update(doc.content).digest('hex'),
          required: doc.required,
          isDraft: consentData.isDraft,
        },
      });
    }

    // Los recursos se reemplazan completos por país: la fuente es el JSON.
    await prisma.$transaction([
      prisma.safetyResource.deleteMany({
        where: { countryCode: safetyData.countryCode },
      }),
      prisma.safetyResource.createMany({
        data: safetyData.resources.map((r) => ({
          countryCode: safetyData.countryCode,
          name: r.name,
          description: r.description,
          phone: r.phone,
          hours: r.hours,
          sortOrder: r.sortOrder,
          verifiedSourceUrl: r.verifiedSourceUrl,
          verifiedAt: new Date(r.verifiedAt),
          clinicalApproval: r.clinicalApproval as ClinicalApproval,
        })),
      }),
    ]);

    console.log(
      `Seed listo: ${consentData.documents.length} documentos, ${safetyData.resources.length} recursos.`,
    );
  } finally {
    await prisma.$disconnect();
  }
}

void main();
