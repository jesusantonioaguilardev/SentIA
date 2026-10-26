-- Permite invalidar access tokens ya emitidos (logout-all, cambio de contraseña).
ALTER TABLE "identity"."users" ADD COLUMN "tokens_valid_after" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
