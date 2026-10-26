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

/// Pide el enlace de restablecimiento. El cambio de contraseña ocurre en la
/// página web del enlace (backend), sin deep links en Etapa 1.
class ForgotPasswordScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final email = useTextEditingController();
    final sent = useState(false);
    final state = ref.watch(forgotPasswordFormProvider);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      sent.value = await ref
          .read(forgotPasswordFormProvider.notifier)
          .submit(email.text);
    }

    return AuthLayout(
      title: sent.value ? l10n.forgotSentTitle : l10n.forgotTitle,
      subtitle: sent.value ? l10n.forgotSentBody : l10n.forgotBody,
      showBack: true,
      child: sent.value
          ? SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go(Routes.login),
                child: Text(l10n.forgotBackToLogin),
              ),
            )
          : Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FieldLabel(l10n.authEmailLabel),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    onFieldSubmitted: (_) => submit(),
                    decoration: InputDecoration(
                      hintText: l10n.authEmailHint,
                      prefixIcon: const Icon(Icons.mail_outline),
                    ),
                    validator: (v) => AuthValidators.isEmail(v ?? '')
                        ? null
                        : l10n.validationEmail,
                  ),
                  const SizedBox(height: Spacing.lg),
                  if (state case AsyncError(:final error)) ...[
                    FormError(authErrorMessage(error, l10n)),
                    const SizedBox(height: Spacing.md),
                  ],
                  SubmitButton(
                    label: l10n.forgotButton,
                    loading: state.isLoading,
                    onPressed: submit,
                  ),
                ],
              ),
            ),
    );
  }
}
