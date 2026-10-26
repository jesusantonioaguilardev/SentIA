import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/auth/domain/auth_validators.dart';
import 'package:sentia2/features/auth/presentation/auth_error_message.dart';
import 'package:sentia2/features/auth/presentation/controllers/auth_form_controllers.dart';
import 'package:sentia2/features/auth/presentation/widgets/auth_layout.dart';
import 'package:sentia2/l10n/app_localizations.dart';

/// Registro: correo, contraseña, año de nacimiento y autodeclaración de
/// mayoría de edad (solo +18 en el MVP, docs/12).
class SignupScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final confirm = useTextEditingController();
    final birthYear = useTextEditingController();
    final obscure = useState(true);
    final ageConfirmed = useState(false);
    final ageError = useState(false);
    final state = ref.watch(signupFormProvider);

    Future<void> submit() async {
      final valid = formKey.currentState!.validate();
      ageError.value = !ageConfirmed.value;
      if (!valid || !ageConfirmed.value) return;
      await ref
          .read(signupFormProvider.notifier)
          .submit(
            email: email.text,
            password: password.text,
            birthYear: int.parse(birthYear.text),
          );
    }

    final visibilityToggle = IconButton(
      tooltip: obscure.value ? l10n.authShowPassword : l10n.authHidePassword,
      icon: Icon(
        obscure.value
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
      ),
      onPressed: () => obscure.value = !obscure.value,
    );

    return AuthLayout(
      title: l10n.signupTitle,
      subtitle: l10n.signupSubtitle,
      showBack: true,
      footer: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            l10n.authHaveAccount,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () => context.go(Routes.login),
            child: Text(l10n.authLoginLink),
          ),
        ],
      ),
      child: AutofillGroup(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldLabel(l10n.authEmailLabel),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  hintText: l10n.authEmailHint,
                  prefixIcon: const Icon(Icons.mail_outline),
                ),
                validator: (v) => AuthValidators.isEmail(v ?? '')
                    ? null
                    : l10n.validationEmail,
              ),
              const SizedBox(height: Spacing.md),
              FieldLabel(l10n.authPasswordLabel),
              TextFormField(
                controller: password,
                obscureText: obscure.value,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: visibilityToggle,
                  helperText: l10n.signupPasswordHelp,
                  helperMaxLines: 3,
                ),
                validator: (v) => AuthValidators.isValidPassword(v ?? '')
                    ? null
                    : l10n.validationPasswordLength,
              ),
              const SizedBox(height: Spacing.md),
              FieldLabel(l10n.signupConfirmPasswordLabel),
              TextFormField(
                controller: confirm,
                obscureText: obscure.value,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (v) =>
                    v == password.text ? null : l10n.validationPasswordsDiffer,
              ),
              const SizedBox(height: Spacing.md),
              FieldLabel(l10n.signupBirthYearLabel),
              TextFormField(
                controller: birthYear,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: const InputDecoration(
                  hintText: '1995',
                  prefixIcon: Icon(Icons.cake_outlined),
                ),
                validator: (v) =>
                    AuthValidators.isValidBirthYear(int.tryParse(v ?? ''))
                    ? null
                    : l10n.validationBirthYear,
              ),
              const SizedBox(height: Spacing.sm),
              CheckboxListTile(
                value: ageConfirmed.value,
                onChanged: (v) {
                  ageConfirmed.value = v ?? false;
                  if (ageConfirmed.value) ageError.value = false;
                },
                title: Text(
                  l10n.signupAgeConfirm,
                  style: theme.textTheme.bodyMedium,
                ),
                subtitle: ageError.value
                    ? Text(
                        l10n.validationAgeConfirm,
                        style: TextStyle(color: theme.colorScheme.error),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: Spacing.sm),
              if (state case AsyncError(:final error)) ...[
                FormError(authErrorMessage(error, l10n)),
                const SizedBox(height: Spacing.md),
              ],
              SubmitButton(
                label: l10n.signupButton,
                loading: state.isLoading,
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
