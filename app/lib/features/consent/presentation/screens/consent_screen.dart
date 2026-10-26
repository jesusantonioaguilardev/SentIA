import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/failure_message.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/features/consent/domain/consent.dart';
import 'package:sentia2/features/consent/presentation/controllers/consent_controller.dart';
import 'package:sentia2/features/consent/presentation/widgets/consent_document_sheet.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/crisis_button.dart';

/// Consentimiento expreso y versionado (docs/09 §1): casillas sin marcar,
/// los obligatorios habilitan "Aceptar y continuar"; el de investigación es
/// opcional. Cada decisión queda registrada con versión y fecha en el backend.
class ConsentScreen extends HookConsumerWidget {
  const new({required this.onCompleted, required this.onSignOut, super.key});

  /// Se llama cuando todos los obligatorios quedaron registrados.
  final VoidCallback onCompleted;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final consents = ref.watch(myConsentsProvider);
    final checked = useState<Map<String, bool>>({});
    final saving = useState(false);
    final error = useState<Failure?>(null);

    Future<void> accept(List<ConsentStatus> statuses) async {
      saving.value = true;
      error.value = null;
      final decisions = {
        for (final s in statuses)
          s.document.id: checked.value[s.document.id] ?? false,
      };
      final result = await ref
          .read(myConsentsProvider.notifier)
          .recordAll(decisions);
      saving.value = false;
      switch (result) {
        case Ok():
          onCompleted();
        case Err(:final failure):
          error.value = failure;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.consentTitle),
        automaticallyImplyLeading: false,
        actions: const [CrisisButton()],
      ),
      body: SafeArea(
        child: switch (consents) {
          AsyncData(:final value) => _ConsentList(
            statuses: value,
            checked: checked.value,
            onChanged: (id, {required granted}) =>
                checked.value = {...checked.value, id: granted},
          ),
          AsyncError(:final error) => _Retry(
            message: Failure.from(error).message(l10n),
            onRetry: () => ref.invalidate(myConsentsProvider),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
      bottomNavigationBar: consents.whenOrNull(
        data: (statuses) {
          final ready = statuses
              .where((s) => s.document.required)
              .every((s) => checked.value[s.document.id] ?? false);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Spacing.margin,
                Spacing.sm,
                Spacing.margin,
                Spacing.md,
              ),
              child: ConstrainedContent(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (error.value != null) ...[
                      Text(
                        error.value!.message(l10n),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: ready && !saving.value
                            ? () => accept(statuses)
                            : null,
                        child: saving.value
                            ? const SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(l10n.consentAcceptButton),
                      ),
                    ),
                    TextButton(
                      onPressed: onSignOut,
                      child: Text(l10n.consentSignOut),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ConsentList extends StatelessWidget {
  const new({
    required this.statuses,
    required this.checked,
    required this.onChanged,
  });

  final List<ConsentStatus> statuses;
  final Map<String, bool> checked;
  final void Function(String documentId, {required bool granted}) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final anyDraft = statuses.any((s) => s.document.isDraft);
    // Obligatorios primero; el opcional de investigación al final.
    final ordered = [...statuses]
      ..sort(
        (a, b) => (b.document.required ? 1 : 0) - (a.document.required ? 1 : 0),
      );

    return ListView(
      padding: const EdgeInsets.all(Spacing.margin),
      children: [
        ConstrainedContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.consentSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (anyDraft) ...[
                const SizedBox(height: Spacing.md),
                DraftBanner(text: l10n.consentDraftBanner),
              ],
              const SizedBox(height: Spacing.md),
              for (final status in ordered) ...[
                _ConsentCard(
                  document: status.document,
                  checked: checked[status.document.id] ?? false,
                  onChanged: (v) => onChanged(status.document.id, granted: v),
                ),
                const SizedBox(height: Spacing.sm + Spacing.xs),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ConsentCard extends StatelessWidget {
  const new({
    required this.document,
    required this.checked,
    required this.onChanged,
  });

  final ConsentDocument document;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    document.title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  document.required
                      ? l10n.consentRequired
                      : l10n.consentOptional,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Text(
              l10n.consentVersion(document.version),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => showConsentDocument(context, document),
                icon: const Icon(Icons.article_outlined, size: 18),
                label: Text(l10n.consentReadDocument),
              ),
            ),
            CheckboxListTile(
              value: checked,
              onChanged: (v) => onChanged(v ?? false),
              title: Text(
                document.required
                    ? l10n.consentAcceptRequired
                    : l10n.consentAcceptOptional,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}

class _Retry extends StatelessWidget {
  const new({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: Spacing.md),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context).commonRetry),
          ),
        ],
      ),
    ),
  );
}
