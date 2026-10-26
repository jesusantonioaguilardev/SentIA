# Documentación SentIA — Índice

**Estado:** Etapa 0 (fundaciones) · **Stack:** Flutter · NestJS · PostgreSQL · **Última revisión:** 2026-10-10

## Fuentes de esta documentación
1. *SentIA — Archivo Maestro de Contexto* (fuente principal de producto y ética).
2. *Propuesta Integral de Proyecto* (portal de especialistas, seguridad, roadmap, legal).
3. *Proyecto: Asistente Virtual Terapéutico con ChatGPT + RAG* (módulos legales, RAG, familiares, admin, CI/CD).
4. *Cotización TECHX* (modo llamada por voz, detección de riesgo, panel clínico, UX, QA, ciberseguridad).

Las propuestas de terceros usaban stacks distintos (.NET/MAUI, Kotlin/KMP, Node). **Decisión vigente:** Flutter + NestJS + PostgreSQL (ver `adr/`). De esas propuestas se toma el **alcance funcional**, no la tecnología.

## Cómo leer
- Agentes de IA → empezar por [`../AGENTS.md`](../AGENTS.md) (reglas) y [`../CLAUDE.md`](../CLAUDE.md) (contexto operativo y deuda actual del código)
- Producto → `01-producto.md`
- ¿Qué construyo ahora? → `02-roadmap-por-etapas.md`
- ¿Cómo encaja todo? → `03-arquitectura.md`
- ¿Dónde va el código? → `04-app-flutter.md`, `05-backend-nestjs.md`
- ¿Qué guardo y cómo? → `06-base-de-datos.md`
- IA → `07-ia-conversacional.md` + `08-seguridad-y-crisis.md` (obligatorio juntos)
- Leyes y tiendas → `09-legal-y-cumplimiento.md`
- Calidad → `10-calidad-y-pruebas.md`
- Reglas para agentes de IA → `11-guia-para-agentes-ia.md`
- Huecos → `12-decisiones-pendientes.md`
- Diseño visual y pantallas → `design/README.md`

## Convenciones de estos documentos
- **[MVP]** = entra en la primera versión publicable. **[ESC]** = escalable/posterior.
- **[PENDIENTE]** = no decidido; no implementar sin confirmación.
- **[VALIDAR-LEGAL]** / **[VALIDAR-CLÍNICO]** = requiere revisión de abogado o psicólogo antes de producción.
