import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/failure_message.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/features/status/domain/server_status.dart';
import 'package:sentia2/features/status/presentation/controllers/server_status_controller.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/sentia_logo.dart';

/// Pantalla "Hola" de Etapa 0: muestra el flavor y el estado del backend.
class StatusScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final flavor = ref.watch(appConfigProvider).flavor;
    final status = ref.watch(serverStatusControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.margin),
          child: ConstrainedContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SentiaLogo(size: 56),
                ),
                const SizedBox(height: Spacing.md),
                Text(l10n.statusTitle, style: theme.textTheme.headlineMedium),
                const SizedBox(height: Spacing.sm),
                Text(
                  l10n.statusSubtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Spacing.lg),
                Text(l10n.statusEnvironment(flavor.name)),
                const SizedBox(height: Spacing.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.margin),
                    child: switch (status) {
                      AsyncData(:final value) => _StatusRow.fromStatus(
                        value,
                        l10n,
                        theme.colorScheme,
                      ),
                      AsyncError(:final error) => _StatusRow(
                        icon: Icons.cloud_off_outlined,
                        color: theme.colorScheme.error,
                        label: Failure.from(error).message(l10n),
                      ),
                      _ => _StatusRow(
                        icon: Icons.hourglass_empty,
                        color: theme.colorScheme.onSurfaceVariant,
                        label: l10n.statusChecking,
                      ),
                    },
                  ),
                ),
                const SizedBox(height: Spacing.md),
                OutlinedButton.icon(
                  onPressed: status.isLoading
                      ? null
                      : () => ref
                            .read(serverStatusControllerProvider.notifier)
                            .retry(),
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.statusRetry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const new({required this.icon, required this.color, required this.label});

  factory fromStatus(
    ServerStatus status,
    AppLocalizations l10n,
    ColorScheme colors,
  ) => status.databaseUp
      ? _StatusRow(
          icon: Icons.check_circle_outline,
          color: colors.primary,
          label: l10n.statusServerOk,
        )
      : _StatusRow(
          icon: Icons.warning_amber_rounded,
          color: colors.error,
          label: l10n.statusServerDegraded,
        );

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      // El texto ya describe el estado; el ícono es decorativo.
      ExcludeSemantics(child: Icon(icon, color: color)),
      const SizedBox(width: Spacing.sm + Spacing.xs),
      Expanded(child: Text(label)),
    ],
  );
}
