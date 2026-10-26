import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/failure_message.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/profile/domain/profile.dart';
import 'package:sentia2/features/profile/presentation/controllers/profile_controller.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/crisis_button.dart';
import 'package:sentia2/shared/widgets/privacy_badge.dart';

class ProfileScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        actions: [
          IconButton(
            tooltip: l10n.profileSettings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
          ),
          const CrisisButton(),
        ],
      ),
      body: switch (profile) {
        AsyncData(:final value) => _ProfileForm(profile: value),
        AsyncError(:final error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Failure.from(error).message(l10n)),
                const SizedBox(height: Spacing.md),
                OutlinedButton(
                  onPressed: () => ref.invalidate(profileControllerProvider),
                  child: Text(l10n.commonRetry),
                ),
              ],
            ),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ProfileForm extends HookConsumerWidget {
  const new({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final displayName = useTextEditingController(text: profile.displayName);
    final contactName = useTextEditingController(
      text: profile.emergencyContact?.name,
    );
    final contactPhone = useTextEditingController(
      text: profile.emergencyContact?.phone,
    );
    final saving = useState(false);
    final controller = ref.read(profileControllerProvider.notifier);

    void notify(Result<Object?> result) {
      final message = switch (result) {
        Ok() => l10n.profileSaved,
        Err(:final failure) => failure.message(l10n),
      };
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> save() async {
      if (!formKey.currentState!.validate()) return;
      saving.value = true;
      final hasContact = contactName.text.trim().isNotEmpty;
      final result = await controller.save(
        displayName: displayName.text.trim().isEmpty
            ? null
            : displayName.text.trim(),
        emergencyContact: hasContact
            ? EmergencyContact(name: contactName.text, phone: contactPhone.text)
            : null,
      );
      saving.value = false;
      if (context.mounted) notify(result);
    }

    Future<void> removeContact() async {
      final result = await controller.removeEmergencyContact();
      contactName.clear();
      contactPhone.clear();
      if (context.mounted) notify(result);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.margin),
      child: ConstrainedContent(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(profile.email, style: theme.textTheme.titleMedium),
              const SizedBox(height: Spacing.lg),
              TextFormField(
                controller: displayName,
                maxLength: 60,
                decoration: InputDecoration(
                  labelText: l10n.profileDisplayNameLabel,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: Spacing.lg),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.profileEmergencyTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: Spacing.xs),
                      Text(
                        l10n.profileEmergencyBody,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: PrivacyBadge(label: l10n.privacyBadgePersonal),
                      ),
                      const SizedBox(height: Spacing.md),
                      TextFormField(
                        controller: contactName,
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: l10n.profileEmergencyName,
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      TextFormField(
                        controller: contactPhone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: l10n.profileEmergencyPhone,
                          hintText: '+52 55 1234 5678',
                        ),
                        validator: (v) {
                          final hasName = contactName.text.trim().isNotEmpty;
                          if (!hasName && (v ?? '').trim().isEmpty) return null;
                          return isValidPhone(v ?? '')
                              ? null
                              : l10n.validationPhone;
                        },
                      ),
                      if (profile.emergencyContact != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: removeContact,
                            child: Text(l10n.profileEmergencyRemove),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Spacing.lg),
              FilledButton(
                onPressed: saving.value ? null : save,
                child: Text(l10n.commonSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
