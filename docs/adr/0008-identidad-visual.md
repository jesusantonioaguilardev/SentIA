# ADR-0008: Identidad visual "Serena & Calma"

- **Estado:** Aceptado
- **Fecha:** 2026-10-25

## Contexto
`docs/12` tenía la identidad visual como [PENDIENTE]. Se recibieron diseños de la app (login, home, chat) y del portal clínico (8 pantallas) con un sistema de diseño completo.

## Decisión
- Se adopta el sistema **"Serena & Calma"** ([docs/design/DESIGN.md](../design/DESIGN.md)): paleta azul cielo / salvia / lavanda, Plus Jakarta Sans, formas de píldora, superficies tonales con sombras ambientales.
- Se implementa por **tokens** (`app/lib/app/theme/`), no copiando los prototipos HTML.
- Cada pantalla se construye en su etapa del roadmap. Donde un diseño choca con seguridad, legal o clínica, mandan `docs/` y la revisión de [docs/design/README.md](../design/README.md).

## Consecuencias
- Pantallas nuevas y reescritas usan el tema y los componentes compartidos; nada de colores ni tamaños escritos a mano.
- El modo oscuro (no diseñado) queda derivado y por validar.
- El portal web hereda los mismos tokens (Flutter Web o Next.js sigue [PENDIENTE]).
