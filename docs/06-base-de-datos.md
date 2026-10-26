# 06 · Base de datos (PostgreSQL)

Convenciones: tablas `snake_case` plural, PK `id uuid` (v7 preferente), `created_at`/`updated_at timestamptz`, borrado lógico solo donde se indique. Campos `*_enc` = cifrados a nivel de aplicación (bytea).
Separación lógica (schemas): `identity` (cuenta), `clinical` (contenido sensible), `ops` (auditoría, notificaciones), `kb` (conocimiento). Así se separan datos administrativos de conversacionales.

## identity
> Implementado en Etapa 1: ver `backend/prisma/schema.prisma` (fuente de verdad). Diferencias con este bosquejo: `subject_id` seudónimo en users, `user_consents` y `audit_log` (sobreviven al borrado, ADR-0007); `tokens_valid_after`; `one_time_tokens` (restablecer/borrar); sin `pending_deletion` (borrado inmediato); `safety_resources.clinical_approval`.
```
users(id, email uniq, password_hash, role enum[user,specialist,admin], status enum[active,suspended,pending_deletion],
      birth_year, country_code, locale, mfa_secret_enc null, deletion_requested_at null, created_at, updated_at)
refresh_tokens(id, user_id fk, token_hash, family_id, expires_at, revoked_at, device_info)
user_profiles(user_id pk/fk, display_name, pronouns null, timezone,
      emergency_contact_name_enc null, emergency_contact_phone_enc null)
consent_documents(id, type enum[privacy_notice,terms,sensitive_data,ai_disclaimer,recording,specialist_sharing],
      version, content_hash, published_at, locale)
user_consents(id, user_id fk, document_id fk, granted bool, granted_at, revoked_at null, ip_hash, app_version)
```

## clinical
```
chat_sessions(id, user_id fk, mode enum[text,voice], started_at, ended_at, summary_enc null, risk_max_level int)
chat_messages(id, session_id fk, role enum[user,assistant,system_safety], content_enc, risk_level int,
      model_provider, model_name, prompt_version, tokens_in, tokens_out, created_at)
memory_summaries(id, user_id fk, period_start, period_end, summary_enc, version)
mood_entries(id, user_id fk, score smallint(1..5 o 0..10 [PENDIENTE]), emotions text[], note_enc null, created_at)
assessment_definitions(id, code uniq [ASQ,TQ,TOP8,HAMA], version, definition jsonb, self_administered bool, active)
assessment_responses(id, user_id fk, definition_id fk, administered_by fk users null, answers_enc,
      score jsonb, result_band text null, triggered_safety bool, created_at)
emotional_profile_snapshots(id, user_id fk, data jsonb (tendencias, temas; sin diagnósticos), created_at)
risk_events(id, user_id fk, source enum[chat,voice,assessment,mood], source_id, level int, signals jsonb,
      action_taken jsonb, acknowledged_by fk null, acknowledged_at null, created_at)
voice_recordings(id, session_id fk, storage_key, duration_s, consent_id fk, expires_at)   -- Etapa 4
```

## especialistas (Etapa 4–5)
```
specialist_profiles(user_id pk/fk, license_number, license_verified_at null, specialty)
care_links(id, patient_id fk, specialist_id fk, status enum[pending,active,revoked], consent_id fk, created_at)
clinical_notes(id, care_link_id fk, author_id fk, content_enc, created_at)
therapy_goals(id, care_link_id fk, title, description_enc, status, due_date)
alert_thresholds(id, care_link_id fk null, rule jsonb, created_by)
assistant_feedback(id, message_id fk, specialist_id fk, rating, comment_enc)
```

## ops
```
audit_log(id bigserial, actor_id, actor_role, action, resource_type, resource_id, reason null, ip_hash, at)
      -- append-only: sin UPDATE/DELETE (permisos de BD + trigger); considerar hash encadenado
notifications(id, user_id, channel enum[push,email,sms], template, status, sent_at, ack_at)
device_tokens(id, user_id, platform, token, last_seen_at)
feature_flags(key pk, enabled, rules jsonb)
prompt_versions(id, name, version, content, status enum[draft,approved,retired], approved_by, created_at)
ai_usage(id, user_id, provider, tokens_in, tokens_out, cost_usd, at)
safety_resources(id, country_code, name, phone null, url null, hours, verified_source_url, verified_at, active)
data_requests(id, user_id, type enum[access,rectification,cancellation,opposition,export], status, created_at, resolved_at)
```

## kb (Etapa 5)
```
kb_documents(id, title, source, version, status enum[draft,approved,retired], approved_by, approved_at)
kb_chunks(id, document_id fk, content, embedding vector(N), metadata jsonb)
```

## Reglas
- Índices: FK, `(user_id, created_at desc)` en tablas de historial, HNSW en `kb_chunks.embedding`.
- Retención [PENDIENTE/VALIDAR-LEGAL]: definir por tabla (mensajes, grabaciones, audit_log).
- Migraciones solo vía Prisma; nunca editar una migración aplicada.
- Datos de staging: sintéticos (seed), nunca copia de producción.
- Room/Kotlin del Master Context quedan sustituidos por PostgreSQL (servidor) + drift cifrado (caché local opcional).
