import 'package:flutter/material.dart';
import 'package:sentia2/app/theme/sentia_colors.dart';
import 'package:sentia2/app/theme/tokens.dart';

/// Bottom nav flotante con esquinas muy redondeadas, acorde al lenguaje
/// visual de SentIA. Se adapta a modo claro y oscuro vía Theme.of(context)
/// — no usa colores hardcodeados.
class RoundedBottomNav extends StatelessWidget {
  const new({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<({IconData icon, String label})> items;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.labelSmall;
    final shadow = context.sentiaColors.ambientShadow;

    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.md, 0, Spacing.md, Spacing.md),
      child: Container(
        // Altura mínima, no fija: con texto grande (hasta 200 %, docs/04) la
        // barra crece en vez de desbordarse.
        constraints: const BoxConstraints(minHeight: 68),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.sm,
          vertical: Spacing.xs,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(Radii.lg),
          // Sombra ambiental del diseño: profundidad sin bordes duros.
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 32,
              spreadRadius: -4,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == currentIndex;
            return Expanded(
              child: Semantics(
                button: true,
                selected: isSelected,
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors.primaryFixed
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(Radii.md),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 22,
                          color: isSelected
                              ? colors.primary
                              : colors.onSurfaceVariant,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: labelStyle?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? colors.primary
                                : colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
