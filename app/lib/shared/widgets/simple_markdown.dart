import 'package:flutter/material.dart';
import 'package:sentia2/app/theme/tokens.dart';

/// Muestra el markdown mínimo de los documentos legales: `#` y `##` como
/// títulos, `**texto**` en negrita y párrafos. Evita una dependencia completa
/// de markdown para textos que controlamos nosotros.
class SimpleMarkdown extends StatelessWidget {
  const new(this.source, {super.key});

  final String source;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final blocks = <Widget>[];

    for (final raw in source.split('\n')) {
      final line = raw.trim();
      if (line.isEmpty) continue;
      final (style, content) = switch (line) {
        _ when line.startsWith('### ') => (text.titleSmall, line.substring(4)),
        _ when line.startsWith('## ') => (text.titleMedium, line.substring(3)),
        _ when line.startsWith('# ') => (text.titleLarge, line.substring(2)),
        _ => (text.bodyMedium, line),
      };
      blocks.add(
        Padding(
          padding: const EdgeInsets.only(bottom: Spacing.sm),
          child: Text.rich(_withBold(content, style)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks,
    );
  }

  static TextSpan _withBold(String content, TextStyle? style) {
    final parts = content.split('**');
    return TextSpan(
      style: style,
      children: [
        for (var i = 0; i < parts.length; i++)
          TextSpan(
            text: parts[i],
            style: i.isOdd
                ? const TextStyle(fontWeight: FontWeight.w600)
                : null,
          ),
      ],
    );
  }
}
