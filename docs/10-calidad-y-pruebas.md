# 10 · Calidad, pruebas y CI/CD

## Pirámide de pruebas
| Tipo | App (Flutter) | Backend (NestJS) | Meta |
|---|---|---|---|
| Unit | usecases, controllers, mappers | services, SafetyGate, scoring | ≥ 80 % en `domain/`, `safety`, `assessments`, `auth` |
| Widget / integración | cada pantalla, estados loading/error/data | e2e con BD de prueba (Testcontainers) | Flujos críticos |
| Golden | pantallas clave × 3 breakpoints × claro/oscuro × texto 200 % | — | Detectar regresiones visuales |
| E2E | `integration_test`: registro → consentimiento → chat → crisis → borrar cuenta | — | Por release |
| Seguridad/crisis | — | `test/safety/scenarios` + `evals/` | Recall 100 % nivel ≥ 2 |
| Scoring | — | Golden tests por instrumento | Igualdad exacta con tabla de referencia |
| Carga [ESC] | — | k6: chat y voz concurrentes | Etapa 4+ |

## CI (GitHub Actions)
En cada PR:
1. `dart format --set-exit-if-changed` · `flutter analyze` · `flutter test`
2. Backend: `lint` · `tsc --noEmit` · `test` · `test:e2e` · `prisma migrate diff` (sin drift)
3. Suite de crisis y evals si cambian `safety/`, `ai/`, prompts o léxico.
4. Escaneo de secretos (gitleaks) y dependencias (Dependabot / `npm audit`).
5. Build de los flavors.

En `main`: despliegue a staging. Producción: tag + aprobación manual.

## Observabilidad
- Crash reporting con PII eliminada.
- Métricas: latencia de chat (p50/p95), errores, eventos de riesgo por nivel (sin contenido), costo IA/usuario, tiempo de acuse de alertas.
- Alertas: picos de error, fallas del proveedor IA (activar fallback), SafetyGate caído (**bloquea el chat y muestra recursos**).

## Definition of Done (por tarea)
- [ ] Cumple criterios de la etapa y no rompe reglas de AGENTS.md.
- [ ] Tests nuevos/actualizados; analyze 0 issues; CI verde.
- [ ] Responsive verificado (compact/medium/expanded) y accesibilidad (texto 200 %, Semantics).
- [ ] Strings en ARB; sin datos sensibles en logs.
- [ ] Docs/ADR actualizados si cambió arquitectura, API o BD.

## Checklist de release {#release}
- [ ] Aviso de privacidad, T&C y disclaimers publicados y enlazados (versión correcta).
- [ ] Borrado de cuenta funcional in-app y vía web.
- [ ] Data safety (Play) y Privacy labels/manifest (Apple) actualizados.
- [ ] Declaración de app de salud en Play Console.
- [ ] Recursos de crisis verificados en fuente oficial (fecha de verificación).
- [ ] Suite de crisis 100 %; evals sin regresiones.
- [ ] Prompt en producción con estado `approved`.
- [ ] Pruebas en dispositivos reales: Android gama baja, tablet, iPhone pequeño.
- [ ] Backups y restauración probados.
