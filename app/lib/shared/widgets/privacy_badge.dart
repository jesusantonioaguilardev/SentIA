import 'package:flutter/material.dart';
import 'package:sentia2/app/theme/sentia_colors.dart';
import 'package:sentia2/app/theme/tokens.dart';

/// Insignia discreta de privacidad (candado + texto en lavanda), p. ej.
/// "Tu espacio personal y seguro". El texto debe describir algo cierto:
/// no prometas cifrado de extremo a extremo (docs/design/README.md).
class PrivacyBadge extends StatelessWidget {
  const new({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.sentiaColors;
    final style = Theme.of(context).textTheme.labelSmall
        ?.copyWith(color: colors.onPrivacyContainer);

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.privacyContainer,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md - Spacing.xs,
          vertical: Spacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Icon(
                Icons.lock_outline,
                size: 14,
                color: colors.onPrivacyContainer,
              ),
            ),
            const SizedBox(width: Spacing.xs + 2),
            Flexible(child: Text(label, style: style)),
          ],
        ),
      ),
    );
  }
}
