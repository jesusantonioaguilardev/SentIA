import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/features/safety/data/safety_repository_impl.dart';
import 'package:sentia2/features/safety/domain/safety_resource.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

final FutureProvider<SafetyResources> _resourcesProvider =
    FutureProvider.autoDispose<SafetyResources>(
      (ref) => ref.watch(safetyRepositoryProvider).resources(),
    );

/// "Ayuda inmediata" (docs/08). Zona protegida: accesible sin sesión y sin
/// conexión, con llamada a un toque. Los textos de crisis definitivos los
/// aprueba el responsable clínico [VALIDAR-CLÍNICO].
class HelpScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final resources = ref.watch(_resourcesProvider);
    final showApproval = ref.watch(appConfigProvider).flavor != Flavor.prod;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.helpTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Spacing.margin),
          children: [
            ConstrainedContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.helpIntro, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: Spacing.lg),
                  ...switch (resources) {
                    AsyncData(:final value) => [
                      if (value.fromCache) ...[
                        Text(
                          l10n.helpOfflineNote,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: Spacing.sm),
                      ],
                      for (final r in value.items) ...[
                        _ResourceCard(resource: r, showApproval: showApproval),
                        const SizedBox(height: Spacing.md),
                      ],
                    ],
                    // El repositorio no falla (usa la copia local).
                    AsyncError() => const <Widget>[],
                    _ => const [Center(child: CircularProgressIndicator())],
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  const new({required this.resource, required this.showApproval});

  final SafetyResource resource;
  final bool showApproval;

  Future<void> _launch(BuildContext context, Uri uri) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final opened = await launchUrl(uri).catchError((_) => false);
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.helpCallFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final verified = DateFormat.yMMMd('es').format(resource.verifiedAt);
    final phone = resource.phone;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(resource.name, style: theme.textTheme.titleLarge),
            if (resource.description != null) ...[
              const SizedBox(height: Spacing.xs),
              Text(resource.description!, style: theme.textTheme.bodyMedium),
            ],
            if (resource.hours != null) ...[
              const SizedBox(height: Spacing.xs),
              Text(
                l10n.helpHours(resource.hours!),
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (phone != null) ...[
              const SizedBox(height: Spacing.md),
              FilledButton.icon(
                onPressed: () =>
                    _launch(context, Uri(scheme: 'tel', path: phone)),
                icon: const Icon(Icons.call),
                label: Text(l10n.helpCall(_formatPhone(phone))),
              ),
            ],
            const SizedBox(height: Spacing.sm),
            Text(
              l10n.helpVerified(verified),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () =>
                    _launch(context, Uri.parse(resource.verifiedSourceUrl)),
                child: Text(l10n.helpOpenSource),
              ),
            ),
            if (showApproval && !resource.clinicallyApproved)
              Text(
                l10n.helpPendingClinical,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 8009112000 → 800 911 2000 (solo para mostrar; se marca el original).
  static String _formatPhone(String digits) => digits.length == 10
      ? [
          digits.substring(0, 3),
          digits.substring(3, 6),
          digits.substring(6),
        ].join(' ')
      : digits;
}
