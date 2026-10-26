-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "identity";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "ops";

-- CreateEnum
CREATE TYPE "identity"."UserRole" AS ENUM ('user', 'specialist', 'admin');

-- CreateEnum
CREATE TYPE "identity"."UserStatus" AS ENUM ('active', 'suspended');

-- CreateEnum
CREATE TYPE "identity"."OneTimeTokenPurpose" AS ENUM ('password_reset', 'account_deletion');

-- CreateEnum
CREATE TYPE "identity"."ConsentDocumentType" AS ENUM ('privacy_notice', 'terms', 'sensitive_data', 'ai_disclaimer', 'research');

-- CreateEnum
CREATE TYPE "ops"."DataRequestType" AS ENUM ('access', 'rectification', 'cancellation', 'opposition', 'export');

-- CreateEnum
CREATE TYPE "ops"."DataRequestStatus" AS ENUM ('received', 'completed', 'rejected');

-- CreateEnum
CREATE TYPE "ops"."ClinicalApproval" AS ENUM ('pending', 'approved');

-- CreateTable
CREATE TABLE "identity"."users" (
    "id" UUID NOT NULL,
    "subject_id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "role" "identity"."UserRole" NOT NULL DEFAULT 'user',
    "status" "identity"."UserStatus" NOT NULL DEFAULT 'active',
    "birth_year" SMALLINT NOT NULL,
    "country_code" CHAR(2) NOT NULL DEFAULT 'MX',
    "locale" TEXT NOT NULL DEFAULT 'es-MX',
    "password_changed_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identity"."refresh_tokens" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "token_hash" TEXT NOT NULL,
    "family_id" UUID NOT NULL,
    "expires_at" TIMESTAMPTZ NOT NULL,
    "revoked_at" TIMESTAMPTZ,
    "rotated_at" TIMESTAMPTZ,
    "device_info" TEXT,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identity"."one_time_tokens" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "purpose" "identity"."OneTimeTokenPurpose" NOT NULL,
    "token_hash" TEXT NOT NULL,
    "expires_at" TIMESTAMPTZ NOT NULL,
    "used_at" TIMESTAMPTZ,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "one_time_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identity"."user_profiles" (
    "user_id" UUID NOT NULL,
    "display_name" TEXT,
    "timezone" TEXT NOT NULL DEFAULT 'America/Mexico_City',
    "emergency_contact_name_enc" TEXT,
    "emergency_contact_phone_enc" TEXT,
    "updated_at" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "user_profiles_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "identity"."consent_documents" (
    "id" UUID NOT NULL,
    "type" "identity"."ConsentDocumentType" NOT NULL,
    "version" TEXT NOT NULL,
    "locale" TEXT NOT NULL DEFAULT 'es-MX',
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "content_hash" TEXT NOT NULL,
    "required" BOOLEAN NOT NULL,
    "is_draft" BOOLEAN NOT NULL DEFAULT true,
    "published_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "consent_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identity"."user_consents" (
    "id" UUID NOT NULL,
    "subject_id" UUID NOT NULL,
    "document_id" UUID NOT NULL,
    "granted" BOOLEAN NOT NULL,
    "granted_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revoked_at" TIMESTAMPTZ,
    "app_version" TEXT,
    "ip_hash" TEXT,

    CONSTRAINT "user_consents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ops"."audit_log" (
    "id" BIGSERIAL NOT NULL,
    "actor_subject_id" UUID,
    "actor_role" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "resource_id" TEXT,
    "reason" TEXT,
    "ip_hash" TEXT,
    "at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ops"."data_requests" (
    "id" UUID NOT NULL,
    "subject_id" UUID NOT NULL,
    "type" "ops"."DataRequestType" NOT NULL,
    "status" "ops"."DataRequestStatus" NOT NULL DEFAULT 'received',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolved_at" TIMESTAMPTZ,

    CONSTRAINT "data_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ops"."safety_resources" (
    "id" UUID NOT NULL,
    "country_code" CHAR(2) NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "phone" TEXT,
    "sms" TEXT,
    "url" TEXT,
    "hours" TEXT,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "verified_source_url" TEXT NOT NULL,
    "verified_at" TIMESTAMPTZ NOT NULL,
    "clinical_approval" "ops"."ClinicalApproval" NOT NULL DEFAULT 'pending',
    "active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "safety_resources_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_subject_id_key" ON "identity"."users"("subject_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "identity"."users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "refresh_tokens_token_hash_key" ON "identity"."refresh_tokens"("token_hash");

-- CreateIndex
CREATE INDEX "refresh_tokens_user_id_idx" ON "identity"."refresh_tokens"("user_id");

-- CreateIndex
CREATE INDEX "refresh_tokens_family_id_idx" ON "identity"."refresh_tokens"("family_id");

-- CreateIndex
CREATE UNIQUE INDEX "one_time_tokens_token_hash_key" ON "identity"."one_time_tokens"("token_hash");

-- CreateIndex
CREATE INDEX "one_time_tokens_user_id_purpose_idx" ON "identity"."one_time_tokens"("user_id", "purpose");

-- CreateIndex
CREATE UNIQUE INDEX "consent_documents_type_version_locale_key" ON "identity"."consent_documents"("type", "version", "locale");

-- CreateIndex
CREATE INDEX "user_consents_subject_id_document_id_idx" ON "identity"."user_consents"("subject_id", "document_id");

-- CreateIndex
CREATE INDEX "audit_log_actor_subject_id_at_idx" ON "ops"."audit_log"("actor_subject_id", "at" DESC);

-- CreateIndex
CREATE INDEX "data_requests_subject_id_idx" ON "ops"."data_requests"("subject_id");

-- CreateIndex
CREATE INDEX "safety_resources_country_code_active_idx" ON "ops"."safety_resources"("country_code", "active");

-- AddForeignKey
ALTER TABLE "identity"."refresh_tokens" ADD CONSTRAINT "refresh_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "identity"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity"."one_time_tokens" ADD CONSTRAINT "one_time_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "identity"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity"."user_profiles" ADD CONSTRAINT "user_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "identity"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity"."user_consents" ADD CONSTRAINT "user_consents_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "identity"."consent_documents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;


-- ─── Auditoría append-only (docs/06) ───────────────────────────────────────
-- Agregado a mano: Prisma no modela triggers. Ninguna sesión, ni siquiera la
-- de la propia app, puede modificar o borrar entradas de la bitácora.
CREATE FUNCTION "ops"."audit_log_append_only"() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  RAISE EXCEPTION 'audit_log es append-only: % no permitido', TG_OP
    USING ERRCODE = 'insufficient_privilege';
END;
$$;

CREATE TRIGGER "audit_log_no_update_delete"
  BEFORE UPDATE OR DELETE ON "ops"."audit_log"
  FOR EACH ROW EXECUTE FUNCTION "ops"."audit_log_append_only"();

CREATE TRIGGER "audit_log_no_truncate"
  BEFORE TRUNCATE ON "ops"."audit_log"
  FOR EACH STATEMENT EXECUTE FUNCTION "ops"."audit_log_append_only"();
