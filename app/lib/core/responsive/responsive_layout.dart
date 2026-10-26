import 'package:flutter/widgets.dart';
import 'package:sentia2/core/responsive/breakpoints.dart';

/// Elige el layout según el ancho disponible (no el de la pantalla), para
/// que funcione igual en split-screen y plegables.
///
/// Si no se da [medium] se usa [compact]; si no se da [expanded] se usa
/// [medium] (o [compact]).
class ResponsiveLayout extends StatelessWidget {
  const new({required this.compact, this.medium, this.expanded, super.key});

  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) =>
        switch (WindowSize.fromWidth(constraints.maxWidth)) {
          WindowSize.compact => compact(context),
          WindowSize.medium => (medium ?? compact)(context),
          WindowSize.expanded => (expanded ?? medium ?? compact)(context),
        },
  );
}

/// Centra [child] y limita su ancho a [maxWidth]: en tablet el contenido no
/// se estira de lado a lado.
class ConstrainedContent extends StatelessWidget {
  const new({
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    // Alto del hijo: sin esto, en barras inferiores ocupa toda la pantalla.
    heightFactor: 1,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
