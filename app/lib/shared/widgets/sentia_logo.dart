import 'package:flutter/material.dart';

/// Logo de SentIA (gota con halo), dibujado desde el SVG de
/// docs/design/serena_wellness_logo. Sin dependencias de SVG.
class SentiaLogo extends StatelessWidget {
  const new({this.size = 48, this.semanticLabel = 'SentIA', super.key});

  final double size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    image: true,
    child: SizedBox.square(
      dimension: size,
      child: const CustomPaint(painter: _LogoPainter()),
    ),
  );
}

class _LogoPainter extends CustomPainter {
  const new();

  static const _halo = Color(0xFFECF5FA);
  static const _drop = Color(0xFF3A6B88);
  static const _leaf = Color(0xFF6A9E7F);

  @override
  void paint(Canvas canvas, Size size) {
    // El SVG original usa un viewBox de 100 × 100.
    canvas
      ..scale(size.width / 100, size.height / 100)
      ..drawCircle(const Offset(50, 50), 46, Paint()..color = _halo);

    final outer = Path()
      ..moveTo(50, 22)
      ..cubicTo(38, 34, 33, 48, 37, 62)
      ..cubicTo(41, 74, 53, 78, 63, 72)
      ..cubicTo(73, 66, 76, 52, 70, 38)
      ..cubicTo(65, 28, 57, 23, 50, 22)
      ..close();
    canvas.drawPath(outer, Paint()..color = _drop.withValues(alpha: 0.2));

    final inner = Path()
      ..moveTo(50, 28)
      ..cubicTo(50, 28, 42, 42, 45, 54)
      ..cubicTo(48, 64, 57, 68, 64, 63)
      ..cubicTo(70, 58, 71, 47, 66, 38)
      ..cubicTo(61, 31, 54, 28, 50, 28)
      ..close();
    canvas
      ..drawPath(inner, Paint()..color = _drop)
      ..drawCircle(
        const Offset(42, 46),
        6,
        Paint()..color = _leaf.withValues(alpha: 0.85),
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
