# Bitácora de Desarrollo - SentIA2

Este documento registra los cambios, decisiones arquitectónicas y comandos utilizados en el proyecto para mantener un control total y facilitar el aprendizaje.

## 2026-10-10 - Documentación para agentes y revisión de docs/

### Tareas Realizadas:
1. **Revisión de `docs/`** (00–12 + ADRs) contra el código actual. El código es anterior a los docs; la deuda quedó inventariada en `CLAUDE.md`.
2. **Creados `CLAUDE.md` y `AGENTS.md`** en la raíz (entregable transversal de Etapa 0).
3. **Docs actualizados:** `12` (nuevas decisiones pendientes: modelo de negocio y borrado vs auditoría como bloqueantes de Etapa 1, monorepo, bundle id, feature flags, set de evaluación de crisis, edad autodeclarada); `08` (recursos de crisis empaquetados para offline; separación tuning/holdout); `03` (streaming fuera del codegen; cifrado en reposo vs envío al LLM); `02` (tareas de migración y git); `00` (enlaces a AGENTS/CLAUDE).
4. **Modo oscuro forzado temporalmente** en `lib/app.dart` (`TODO(etapa-1)`: preferencia en Ajustes).

---

## [Fecha Actual] - Resolución de Errores de Sincronización y Compilación

### Tareas Realizadas:
1. **Saneamiento de Entorno:** Se identificó un conflicto en la caché (`Invalid depfile`) y falta de archivos generados. Se estableció el flujo de limpieza profunda.
2. **Corrección de app_theme.dart:** Se cambió `CardTheme` por `CardThemeData` (clase de configuración correcta) eliminando el error de asignación de tipos en el constructor del tema.
3. **Compatibilidad de Colores:** Se migró temporalmente de `.withValues()` a `.withOpacity()` para asegurar compatibilidad con versiones del SDK de Flutter inferiores a la 3.24 si fuera el caso del usuario.
4. **Validación de Dependencias:** Se confirmó que `intl` está presente para el correcto funcionamiento del historial emocional.

### Comandos de "Rescate" (Si ves todo en rojo):
1. `flutter clean`: Borra la basura técnica de compilaciones fallidas.
2. `flutter pub get`: Descarga las librerías necesarias.
3. `dart run build_runner build --delete-conflicting-outputs`: **INDISPENSABLE**. Genera los archivos `.g.dart` de Riverpod. Sin esto, los providers no existen para Flutter.

---

## [Fecha Anterior] - Implementación de Arquitectura Legal y Flujo de Onboarding
... (Historial conservado) ...
