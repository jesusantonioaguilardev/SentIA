# ADR-0005: Monorepo para app y backend

- **Estado:** Aceptado (reemplaza la parte "repo separado" de ADR-0002)
- **Fecha:** 2026-10-10

## Contexto
ADR-0002 definía el backend en un repositorio separado (`sentia-backend`). El proyecto lo desarrolla 1 persona con apoyo de agentes de IA, y el contrato OpenAPI conecta ambos lados: cada cambio de API toca backend, `openapi.yaml` y el cliente Dart generado.

## Decisión
Un solo repositorio:
```
app/       Flutter (paquete sentia2) + app/packages/sentia_api (cliente generado)
backend/   NestJS (paquete sentia-backend)
docs/      documentación y ADRs
.github/   CI
```
El cliente Dart se genera con `npm run contract` en `backend/` (exporta `openapi.yaml` y regenera `app/packages/sentia_api`).

## Alternativas
- Dos repos: aislamiento y permisos separados, pero cada cambio de API exige PRs coordinados y publicar el cliente como paquete.

## Consecuencias
- Un PR puede cambiar contrato, backend y app a la vez; CI valida que `openapi.yaml` y el código generado estén al día.
- Los agentes de IA ven ambos lados en el mismo contexto.
- Si el equipo crece o se necesitan permisos distintos, se puede separar sin cambiar el contrato.
