/// Tokens de diseño (docs/04 §Diseño). Los widgets usan estos valores, no
/// números mágicos.
abstract final class Spacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Radios de esquina.
abstract final class Radii {
  static const double sm = 12;
  static const double md = 20;
  static const double lg = 28;
  static const double pill = 999;
}

/// Tamaños mínimos de accesibilidad (WCAG 2.1 AA, docs/04).
abstract final class A11y {
  /// Área táctil mínima en dp.
  static const double minTouchTarget = 48;
}
