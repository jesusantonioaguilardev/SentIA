import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentia2/app/session/session_controller.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/failure_message.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/preferences/app_preferences.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/auth/data/api_auth_repository.dart';
import 'package:sentia2/features/consent/domain/consent.dart';
import 'package:sentia2/features/consent/presentation/controllers/consent_controller.dart';
import 'package:sentia2/features/consent/presentation/widgets/consent_document_sheet.dart';
import 'package:sentia2/features/profile/data/api_profile_repository.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/crisis_button.dart';
import 'package:share_plus/share_plus.dart';

/// Ajustes (docs/02 Etapa 1): tema, tamaño de texto, idioma, privacidad,
/// exportación ARCO, sesión y borrado de cuenta.
class SettingsScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.watch(appPreferencesProvider);
    final consents = ref.watch(myConsentsProvider);
    final isProd = ref.watch(appConfigProvider).flavor == Flavor.prod;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        actions: const [CrisisButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: Spacing.md),
        children: [
          ConstrainedContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Section(l10n.settingsAppearance),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.margin,
                  ),
                  child: SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text(l10n.settingsThemeSystem),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text(l10n.settingsThemeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text(l10n.settingsThemeDark),
                      ),
                    ],
                    selected: {prefs.themeMode},
                    onSelectionChanged: (s) => ref
                        .read(appPreferencesProvider.notifier)
                        .setThemeMode(s.first),
                  ),
                ),
                ListTile(
                  title: Text(l10n.settingsTextSize),
                  subtitle: Slider(
                    value: prefs.textScale,
                    min: AppPreferences.minTextScale,
                    max: AppPreferences.maxTextScale,
                    divisions: 9,
                    label: '${(prefs.textScale * 100).round()} %',
                    onChanged: (v) => ref
                        .read(appPreferencesProvider.notifier)
                        .setTextScale(v),
                  ),
                ),
                ListTile(
                  title: Text(l10n.settingsLanguage),
                  subtitle: Text(l10n.settingsLanguageValue),
                  leading: const Icon(Icons.language),
                ),

                _Section(l10n.settingsPrivacy),
                ...switch (consents) {
                  AsyncData(:final value) => [
                    for (final status in value) _ConsentTile(status: status),
                    if (value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.margin,
                        ),
                        child: Text(
                          l10n.settingsLegalVersion(
                            value.first.document.version,
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                  ],
                  AsyncError(:final error) => [
                    ListTile(
                      title: Text(Failure.from(error).message(l10n)),
                      trailing: TextButton(
                        onPressed: () => ref.invalidate(myConsentsProvider),
                        child: Text(l10n.commonRetry),
                      ),
                    ),
                  ],
                  _ => const [LinearProgressIndicator()],
                },

                _Section(l10n.settingsData),
                ListTile(
                  leading: const Icon(Icons.download_outlined),
                  title: Text(l10n.settingsExport),
                  subtitle: Text(l10n.settingsExportBody),
                  onTap: () => _export(context, ref),
                ),

                _Section(l10n.settingsSession),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(l10n.settingsLogout),
                  onTap: () => ref.read(authRepositoryProvider).logout(),
                ),
                ListTile(
                  leading: const Icon(Icons.devices_other_outlined),
                  title: Text(l10n.settingsLogoutAll),
                  onTap: () => _logoutAll(context, ref),
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    l10n.settingsDeleteAccount,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onTap: () => _confirmDelete(context, ref),
                ),
                if (!isProd)
                  ListTile(
                    leading: const Icon(Icons.dns_outlined),
                    title: Text(l10n.settingsServerStatus),
                    onTap: () => context.push(Routes.status),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref.read(profileRepositoryProvider).export();
    switch (result) {
      case Ok(:final value):
        await SharePlus.instance.share(
          ShareParams(
            files: [
              XFile.fromData(
                utf8.encode(value),
                mimeType: 'application/json',
                name: 'sentia-mis-datos.json',
              ),
            ],
            fileNameOverrides: ['sentia-mis-datos.json'],
            text: l10n.settingsExportShareText,
          ),
        );
      case Err(:final failure):
        messenger.showSnackBar(SnackBar(content: Text(failure.message(l10n))));
    }
  }

  Future<void> _logoutAll(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref.read(authRepositoryProvider).logoutAll();
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Ok() => l10n.settingsLogoutAllDone,
          Err(:final failure) => failure.message(l10n),
        }),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final password = await showDialog<String>(
      context: context,
      builder: (_) => const _DeleteAccountDialog(),
    );
    if (password == null || !context.mounted) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(profileRepositoryProvider)
        .deleteAccount(password);
    if (result case Err(:final failure)) {
      messenger.showSnackBar(SnackBar(content: Text(failure.message(l10n))));
    }
    // Si salió bien, los tokens se borraron y la sesión vuelve al inicio.
  }
}

class _Section extends StatelessWidget {
  const new(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      Spacing.margin,
      Spacing.lg,
      Spacing.margin,
      Spacing.sm,
    ),
    child: Semantics(
      header: true,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    ),
  );
}

class _ConsentTile extends ConsumerWidget {
  const new({required this.status});

  final ConsentStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final document = status.document;

    Future<void> change({required bool granted}) async {
      if (!granted) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.settingsRevokeTitle),
            content: Text(
              document.required
                  ? l10n.settingsRevokeRequiredBody
                  : l10n.settingsRevokeOptionalBody,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.commonCancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.settingsRevoke),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
      }
      await ref.read(myConsentsProvider.notifier).recordAll({
        document.id: granted,
      });
      // Retirar un obligatorio devuelve a la pantalla de consentimiento.
      if (document.required) {
        ref.read(sessionProvider.notifier).refreshConsent();
      }
    }

    return SwitchListTile(
      title: Text(document.title),
      subtitle: Text(
        status.granted
            ? l10n.settingsConsentGranted
            : l10n.settingsConsentNotGranted,
      ),
      value: status.granted,
      onChanged: (value) => change(granted: value),
      secondary: IconButton(
        tooltip: l10n.consentReadDocument,
        icon: const Icon(Icons.article_outlined),
        onPressed: () => showConsentDocument(context, document),
      ),
    );
  }
}

class _DeleteAccountDialog extends HookWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final password = useTextEditingController();
    final hasText = useListenableSelector(
      password,
      () => password.text.isNotEmpty,
    );

    return AlertDialog(
      title: Text(l10n.settingsDeleteTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.settingsDeleteBody),
            const SizedBox(height: Spacing.md),
            TextField(
              controller: password,
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: l10n.settingsDeletePassword,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: hasText
              ? () => Navigator.pop(context, password.text)
              : null,
          child: Text(l10n.settingsDeleteConfirm),
        ),
      ],
    );
  }
}
