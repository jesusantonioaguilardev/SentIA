import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sentia2/app/theme/tokens.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/crisis_button.dart';
import 'package:sentia2/shared/widgets/sentia_logo.dart';

/// Bienvenida previa a la cuenta: qué es y qué no es SentIA, y dónde está la
/// ayuda inmediata (docs/02 Etapa 1). El consentimiento formal ocurre después
/// de crear la cuenta, en `features/consent`.
class WelcomeScreen extends HookWidget {
  const new({required this.onCreateAccount, required this.onLogin, super.key});

  final VoidCallback onCreateAccount;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final page = useState(0);
    final controller = usePageController();
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final pages = [
      (Icons.spa_outlined, l10n.welcomeWhatTitle, l10n.welcomeWhatBody),
      (Icons.info_outline, l10n.welcomeWhatNotTitle, l10n.welcomeWhatNotBody),
      (Icons.shield_outlined, l10n.welcomeHelpTitle, l10n.welcomeHelpBody),
    ];
    final isLast = page.value == pages.length - 1;

    void next() {
      final target = page.value + 1;
      if (reduceMotion) {
        controller.jumpToPage(target);
      } else {
        controller.animateToPage(
          target,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(actions: const [CrisisButton()]),
      body: SafeArea(
        top: false,
        child: ConstrainedContent(
          child: Column(
            children: [
              const SentiaLogo(size: 64),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (i) => page.value = i,
                  children: [
                    for (final (icon, title, body) in pages)
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(Spacing.lg),
                        child: Column(
                          children: [
                            const SizedBox(height: Spacing.lg),
                            ExcludeSemantics(
                              child: Icon(
                                icon,
                                size: 56,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: Spacing.lg),
                            Semantics(
                              header: true,
                              child: Text(
                                title,
                                style: theme.textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: Spacing.md),
                            Text(
                              body,
                              style: theme.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              _Dots(count: pages.length, current: page.value),
              Padding(
                padding: const EdgeInsets.all(Spacing.margin),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLast ? onCreateAccount : next,
                        child: Text(
                          isLast
                              ? l10n.welcomeCreateAccount
                              : l10n.commonContinue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: onLogin,
                      child: Text(l10n.welcomeHaveAccount),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const new({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Spacing.xs),
              width: i == current ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == current ? colors.primary : colors.outlineVariant,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
            ),
        ],
      ),
    );
  }
}
