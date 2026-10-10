# ADR-0002: NestJS + PostgreSQL para el backend

- **Estado:** Aceptado
- **Fecha:** 2026-10-10

## Contexto
Se necesita auth con roles, datos sensibles cifrados, streaming de chat, WebSockets para voz, integración con varios proveedores de IA y, más adelante, RAG.

## Decisión
Monolito modular NestJS (TypeScript strict) + Prisma + PostgreSQL (pgvector para RAG). Repo separado; contrato OpenAPI como fuente de verdad del cliente Dart.

## Alternativas
- Ktor (Kotlin): sin ventaja de lenguaje compartido al usar Flutter.
- ASP.NET + Azure: válido, pero menos alineado al equipo actual.
- Firebase: rápido, pero dificulta cifrado por campo, consultas relacionales, auditoría y portabilidad.
- MongoDB: menos adecuado para relaciones (vínculos, consentimientos, auditoría).

## Consecuencias
- Estructura modular clara y fácil de seguir para agentes de IA.
- Un solo motor de BD para relacional + vectores en MVP/ESC.
- Requiere gestionar infraestructura (o servicio gestionado).
