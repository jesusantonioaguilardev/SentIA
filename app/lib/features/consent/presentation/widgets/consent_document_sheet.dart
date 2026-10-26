import 'package:flutter/material.dart';
import 'package:sentia2/app/theme/sentia_colors.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/features/consent/domain/consent.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/simple_markdown.dart';

/// Muestra el texto completo de un documento en una hoja inferior.
Future<void> showConsentDocument(
  BuildContext context,
  ConsentDocument document,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.85,
    maxChildSize: 0.95,
    builder: (context, controller) => ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(
        Spacing.margin,
        0,
        Spacing.margin,
        Spacing.xl,
      ),
      children: [
        if (document.isDraft) ...[
          DraftBanner(text: AppLocalizations.of(context).consentDraftBanner),
          const SizedBox(height: Spacing.md),
        ],
        SimpleMarkdown(document.content),
      ],
    ),
  ),
);

/// Aviso visible de que un texto legal aún no tiene revisión [VALIDAR-LEGAL].
class DraftBanner extends StatelessWidget {
  const new({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.sentiaColors;
    return Semantics(
      container: true,
      child: Container(
        padding: const EdgeInsets.all(Spacing.sm + Spacing.xs),
        decoration: BoxDecoration(
          color: colors.notice.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Radii.base),
          border: Border.all(color: colors.notice.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Icon(Icons.edit_note, color: colors.notice),
            ),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: Text(text, style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        ),
      ),
    );
  }
}
