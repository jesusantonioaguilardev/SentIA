# SentIA

App móvil de **apoyo emocional asistido por IA**. Complementaria: no diagnostica ni sustituye atención profesional ni servicios de emergencia.

| Carpeta | Qué hay |
|---|---|
| [`app/`](app/) | App Flutter (Android/iOS) + cliente de API generado en `app/packages/sentia_api` |
| [`backend/`](backend/) | API NestJS + Prisma + PostgreSQL |
| [`docs/`](docs/00-INDEX.md) | Producto, arquitectura, roadmap, legal, calidad y ADRs |

Etapa actual y siguientes pasos: [docs/02-roadmap-por-etapas.md](docs/02-roadmap-por-etapas.md). Agentes de IA: [AGENTS.md](AGENTS.md) y [CLAUDE.md](CLAUDE.md).

## Arranque rápido

**Requisitos:** [FVM](https://fvm.app) (Flutter 3.47.5, fijado en `app/.fvmrc`), Node ≥ 22, Docker Desktop, Java 17+ (solo para regenerar el cliente de API).

```bash
# Backend
cd backend
cp .env.example .env
npm ci
npm run db:up        # PostgreSQL en Docker
npm run start:dev    # http://localhost:3000/v1/health · Swagger: http://localhost:3000/docs

# App (otra terminal)
cd app
fvm flutter pub get
fvm flutter run --flavor dev -t lib/main_dev.dart
```
El flavor `dev` apunta a `http://10.0.2.2:3000` (el host visto desde el emulador de Android). En un dispositivo físico: `--dart-define=API_BASE_URL=http://<IP-de-tu-PC>:3000`.

La pantalla de estado del servidor ("Hola, soy SentIA") está en la pestaña **Perfil** en los flavors `dev` y `staging`.

## Cambiar la API
1. Cambia controllers/DTOs en `backend/`.
2. `npm run contract` en `backend/`: exporta `openapi.yaml` y regenera `app/packages/sentia_api`.
3. Sube ambos cambios en el mismo PR (CI verifica que estén al día).
