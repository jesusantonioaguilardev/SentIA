# ADR-0001: Flutter para la app móvil

- **Estado:** Aceptado
- **Fecha:** 2026-10-10

## Contexto
SentIA necesita Android e iOS, interfaz responsive (teléfono/tablet), modos claro/oscuro, accesibilidad y animaciones de avatar. Las propuestas previas usaban Kotlin/Compose, KMP o .NET MAUI.

## Decisión
Flutter (Dart) con arquitectura feature-first + capas (data/domain/presentation), Riverpod y go_router.

## Alternativas
- Kotlin + Compose (+KMP para iOS): nativo, pero dos UIs o Compose Multiplatform aún menos maduro en iOS.
- .NET MAUI: menor ecosistema para animación/UI moderna.

## Consecuencias
- Una base de código para ambas plataformas y potencialmente web (portal).
- Las referencias a Kotlin/Room en el Master Context se sustituyen por Flutter + drift.
- Requiere disciplina de capas para que los agentes de IA mantengan consistencia.
