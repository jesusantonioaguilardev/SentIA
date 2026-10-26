/// Tokens de diseño del sistema "Serena & Calma" (docs/design/DESIGN.md).
/// Los widgets usan estos valores, no números mágicos.
abstract final class Spacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 36;
  static const double xxl = 56;

  /// Margen lateral de pantalla en teléfono.
  static const double margin = 20;

  /// Margen lateral en tablet.
  static const double marginTablet = 32;

  /// Separación estándar entre componentes.
  static const double gutter = 16;
}

/// Radios de esquina: lenguaje orgánico de píldoras y curvas amplias.
abstract final class Radii {
  static const double sm = 8;

  /// Campos de texto y filas de lista.
  static const double base = 16;

  /// Tarjetas.
  static const double md = 24;

  /// Tarjetas destacadas, hojas inferiores y diálogos.
  static const double lg = 32;
  static const double xl = 48;
  static const double pill = 9999;
}

/// Tamaños mínimos de accesibilidad (WCAG 2.1 AA, docs/04).
abstract final class A11y {
  /// Área táctil mínima en dp.
  static const double minTouchTarget = 48;
}
