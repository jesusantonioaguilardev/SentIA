import 'package:flutter/widgets.dart';

/// Clases de tamaño de ventana de Material 3 (docs/04 §Responsive).
enum WindowSize {
  /// < 600 dp: teléfono vertical. Bottom navigation, una columna.
  compact,

  /// 600–839 dp: tablet pequeña o plegable. Navigation rail.
  medium,

  /// ≥ 840 dp: tablet grande o escritorio. Rail + dos paneles.
  expanded;

  /// Clase correspondiente a un ancho en dp.
  static WindowSize fromWidth(double width) => switch (width) {
    < Breakpoints.medium => compact,
    < Breakpoints.expanded => medium,
    _ => expanded,
  };

  /// Clase de la ventana actual.
  static WindowSize of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);
}

/// Anchos en dp donde cambia el layout.
abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 840;

  /// Ancho máximo del contenido en medium/expanded para no estirar el texto.
  static const double maxContentWidth = 720;
}
