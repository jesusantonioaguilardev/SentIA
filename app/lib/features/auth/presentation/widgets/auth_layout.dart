import 'package:flutter/material.dart';
import 'package:sentia2/app/theme/sentia_colors.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/crisis_button.dart';
import 'package:sentia2/shared/widgets/privacy_badge.dart';
import 'package:sentia2/shared/widgets/sentia_logo.dart';

/// Estructura de las pantallas de cuenta según docs/design/app/login.png:
/// logo con halo, título, subtítulo, insignia de privacidad, tarjeta blanca
/// con el formulario y un pie sereno.
class AuthLayout extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
    this.showBack = false,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colors = context.sentiaColors;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: showBack,
        actions: const [CrisisButton()],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.margin,
            vertical: Spacing.md,
          ),
          child: ConstrainedContent(
            maxWidth: 448,
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surfaceContainerLow,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(Spacing.sm + Spacing.xs),
                    child: SentiaLogo(size: 72),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                Text(
                  title,
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.md),
                PrivacyBadge(label: l10n.privacyBadgePersonal),
                const SizedBox(height: Spacing.lg),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(Radii.lg),
                    boxShadow: [
                      BoxShadow(
                        color: colors.ambientShadow,
                        blurRadius: 32,
                        spreadRadius: -4,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: child,
                  ),
                ),
                if (footer != null) ...[
                  const SizedBox(height: Spacing.lg),
                  footer!,
                ],
                const SizedBox(height: Spacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExcludeSemantics(
                      child: Icon(
                        Icons.spa_outlined,
                        size: 16,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: Spacing.sm),
                    Flexible(
                      child: Text(
                        l10n.breatheFooter,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Etiqueta sobre un campo, como en el diseño (no flotante).
class FieldLabel extends StatelessWidget {
  const new(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: Spacing.xs, bottom: Spacing.xs + 2),
    child: Text(text, style: Theme.of(context).textTheme.labelMedium),
  );
}

/// Mensaje de error en línea, anunciado a lectores de pantalla.
class FormError extends StatelessWidget {
  const new(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Spacing.sm + Spacing.xs),
        decoration: BoxDecoration(
          color: colors.errorContainer,
          borderRadius: BorderRadius.circular(Radii.base),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.onErrorContainer),
        ),
      ),
    );
  }
}

/// Botón primario con indicador de carga.
class SubmitButton extends StatelessWidget {
  const new({
    required this.label,
    required this.loading,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(label)),
                if (icon != null) ...[
                  const SizedBox(width: Spacing.sm),
                  Icon(icon, size: 18),
                ],
              ],
            ),
    ),
  );
}
