# 04 · App Flutter

## Stack
| Necesidad | Paquete | Nota |
|---|---|---|
| Estado / DI | `flutter_riverpod` + `riverpod_annotation` | Providers generados; nada de singletons globales |
| Navegación | `go_router` | Rutas tipadas, guards de auth/consentimiento |
| Red | `dio` + cliente generado de OpenAPI | Interceptores: auth, refresh, redacción de logs |
| Modelos | `freezed` + `json_serializable` | Inmutables |
| Almacenamiento seguro | `flutter_secure_storage` | Tokens, llave de BD local |
| BD local [ESC] | `drift` + SQLCipher | Caché cifrada offline (Etapa 3+) |
| i18n | `flutter_localizations` + ARB | `es` por defecto |
| Gráficas | `fl_chart` | Mood tracker |
| Animación avatar | `rive` o `lottie` | Etapa 4 |
| Audio | `record`, `just_audio` / WebSocket | Etapa 4 |
| Push | `firebase_messaging` | Payload sin datos sensibles |
| Errores | `sentry_flutter` con `beforeSend` que elimina PII | [PENDIENTE] proveedor |

Versión mínima: Flutter estable vigente; Android `minSdk 24` (sugerido), iOS 13+ [PENDIENTE confirmar].

## Estructura (feature-first + capas limpias)
```
app/                         # raíz del paquete Flutter en el monorepo (ADR-0005)
  packages/sentia_api/       # cliente generado desde backend/openapi.yaml (no editar)
lib/
  main_dev.dart / main_staging.dart / main_prod.dart
  app/
    app.dart                 # MaterialApp.router
    bootstrap.dart           # arranque por flavor + manejo global de errores
    router.dart              # go_router + redirects (auth, consentimiento)
    shell/                   # navegación principal adaptativa (bottom nav / rail)
    theme/                   # tokens, ThemeData claro/oscuro
  core/
    config/                  # Flavor, AppConfig (URL de API por entorno)
    network/                 # dio, interceptores, ApiClient generado
    error/                   # Failure, Result<T>, mapeo de excepciones
    responsive/              # breakpoints, ResponsiveLayout, AdaptiveScaffold
    routing/                 # constantes de rutas (features navegan sin importar app/)
    safety/                  # red de seguridad local offline (zona protegida, 08)
    a11y/                    # helpers de Semantics, reduced motion
    security/                # secure storage
    logging/                 # AppLogger + redactor de datos sensibles
    utils/
  features/
    auth/
      data/                  # datasources (remote/local), repositories_impl, dto
      domain/                # entities, repositories (abstractos), usecases
      presentation/          # screens/, widgets/, controllers/ (Riverpod)
    onboarding/  consent/  chat/  safety/  mood/  assessments/
    profile/  settings/  voice/  specialist/  notifications/
  shared/
    widgets/                 # design system: SButton, SCard, SCrisisButton, ...
  l10n/
    app_es.arb
test/                        # espejo de lib/
integration_test/
```
**Excepción documentada:** `features/home` es un tablero que compone otras features (hoy lee `mood`); es el único feature que puede importar a otros.

**Regla de dependencias:** `presentation → domain ← data`. `domain` no importa Flutter ni `dio`. Un feature no importa otro feature; lo compartido sube a `core/` o `shared/`.

## Responsive (obligatorio)
Breakpoints (Material 3 window size classes), en `core/responsive/breakpoints.dart`:
| Clase | Ancho | Layout |
|---|---|---|
| compact | < 600 dp | Bottom navigation, una columna |
| medium | 600–839 dp | Navigation rail, contenido centrado máx. 720 dp |
| expanded | ≥ 840 dp | Rail/drawer + dos paneles (p. ej. lista de conversaciones + chat) |

Reglas:
- Usa `LayoutBuilder` / `MediaQuery.sizeOf` mediante `ResponsiveLayout`; **nunca** tamaños fijos en px para layouts.
- Soporta rotación, pantallas plegables, split-screen y teclado abierto (`resizeToAvoidBottomInset`).
- Probar cada pantalla en: 360×640, 412×915, 600×1024 (tablet 7"), 800×1280, 1280×800.
- Golden tests por breakpoint para pantallas clave.

## Accesibilidad (WCAG 2.1 AA)
- Respetar `MediaQuery.textScalerOf` hasta 200 % sin overflow (probar con texto grande).
- Contraste ≥ 4.5:1 texto normal, 3:1 texto grande/íconos.
- Áreas táctiles ≥ 48×48 dp.
- `Semantics` en íconos-botón, gráficas (descripción textual) y avatar.
- Respetar "reducir movimiento" (`MediaQuery.disableAnimations`).
- Subtítulos en voz; nada se comunica solo por color.

## Diseño
- Material 3, `ColorScheme.fromSeed` con paleta calmante [PENDIENTE: identidad visual final].
- Tokens (espaciado 4/8/12/16/24/32, radios, tipografía) en `app/theme/tokens.dart`; widgets usan tokens, no números mágicos.
- Botón de crisis (`SCrisisButton`) en AppBar de chat, voz y resultados de tests.

## Estado y errores
- Controllers con `AsyncNotifier`; UI maneja `loading / data / error` siempre.
- Repositorios devuelven `Result<T, Failure>`; la UI muestra mensajes amables y localizados.
- Sin conexión: chat muestra estado y encola; la pantalla de ayuda de crisis funciona offline.

## Seguridad en el cliente
- Tokens solo en `flutter_secure_storage`. Nada sensible en `SharedPreferences`.
- `FLAG_SECURE` en Android para chat, tests y resultados [PENDIENTE confirmar UX]; ocultar contenido en el app switcher en iOS.
- Bloqueo opcional con biometría (`local_auth`) [Etapa 2–3].
- Certificate pinning [ESC].
- Ofuscación en release: `--obfuscate --split-debug-info`.

## Convenciones
- Archivos `snake_case.dart`; clases `PascalCase`; providers `xxxProvider`.
- Un widget público por archivo; widgets privados `_Nombre` en el mismo archivo.
- Strings solo vía `AppLocalizations`.
- Todo widget de pantalla tiene al menos un widget test.
