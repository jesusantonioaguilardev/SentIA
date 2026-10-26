import 'package:flutter/material.dart';
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

/// Inicio de sesión (docs/design/app/login.png, sin "Continuar con Google").
class LoginScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final obscure = useState(true);
    final state = ref.watch(loginFormProvider);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      await ref
          .read(loginFormProvider.notifier)
          .submit(email: email.text, password: password.text);
    }

    return AuthLayout(
      title: l10n.appTitle,
      subtitle: l10n.appTagline,
      footer: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            l10n.authNoAccount,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () => context.go(Routes.signup),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.secondary,
            ),
            child: Text(l10n.authCreateAccount),
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
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                onFieldSubmitted: (_) => submit(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    tooltip: obscure.value
                        ? l10n.authShowPassword
                        : l10n.authHidePassword,
                    icon: Icon(
                      obscure.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () => obscure.value = !obscure.value,
                  ),
                ),
                validator: (v) =>
                    (v ?? '').isEmpty ? l10n.validationRequired : null,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push(Routes.forgotPassword),
                  child: Text(l10n.authForgotPassword),
                ),
              ),
              if (state case AsyncError(:final error)) ...[
                FormError(authErrorMessage(error, l10n)),
                const SizedBox(height: Spacing.md),
              ],
              SubmitButton(
                label: l10n.authLoginButton,
                icon: Icons.arrow_forward,
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
