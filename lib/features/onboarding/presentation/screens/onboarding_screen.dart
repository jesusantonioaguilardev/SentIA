import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentia2/core/constants/legal_texts.dart';
import 'package:sentia2/domain/entities/user_consent.dart';
import 'package:sentia2/features/auth/presentation/providers/auth_provider.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final pageController = usePageController();
    final currentPage = useState(0);

    // Estados de consentimiento con versión y fecha
    final sensitiveDataConsent = useState<bool>(false);
    final clinicalLimitConsent = useState<bool>(false);
    final professionalLinkConsent = useState<bool>(false);
    final researchConsent = useState<bool>(false);

    const String currentDocVersion = '1.0.0';

    final List<Widget> steps = [
      _InfoStep(
        title: 'Qué es SentIA',
        content: LegalTexts.informedConsentStep1,
        image: Icons.psychology_outlined,
      ),
      _ConsentStep(
        title: 'Datos Sensibles',
        content: LegalTexts.informedConsentStep2,
        value: sensitiveDataConsent.value,
        onChanged: (v) => sensitiveDataConsent.value = v ?? false,
        isRequired: true,
      ),
      _ConsentStep(
        title: 'Límite Clínico',
        content: LegalTexts.informedConsentStep3,
        value: clinicalLimitConsent.value,
        onChanged: (v) => clinicalLimitConsent.value = v ?? false,
        isRequired: true,
      ),
      _ConsentStep(
        title: 'Vinculación (Opcional)',
        content: LegalTexts.informedConsentStep4,
        value: professionalLinkConsent.value,
        onChanged: (v) => professionalLinkConsent.value = v ?? false,
        isRequired: false,
      ),
      _ConsentStep(
        title: 'Investigación (Opcional)',
        content: LegalTexts.informedConsentStep5,
        value: researchConsent.value,
        onChanged: (v) => researchConsent.value = v ?? false,
        isRequired: false,
      ),
    ];

    void _finishOnboarding() {
      final consent = UserConsent(
        sensitiveData: ConsentRecord(
          accepted: sensitiveDataConsent.value,
          documentVersion: currentDocVersion,
          timestamp: DateTime.now(),
        ),
        clinicalLimit: ConsentRecord(
          accepted: clinicalLimitConsent.value,
          documentVersion: currentDocVersion,
          timestamp: DateTime.now(),
        ),
        professionalLink: ConsentRecord(
          accepted: professionalLinkConsent.value,
          documentVersion: currentDocVersion,
          timestamp: DateTime.now(),
        ),
        researchImprovement: ConsentRecord(
          accepted: researchConsent.value,
          documentVersion: currentDocVersion,
          timestamp: DateTime.now(),
        ),
      );
      
      // ref.read(authProvider.notifier).saveConsent(consent);
      Navigator.of(context).pushReplacementNamed('/home');
    }

    bool _canContinue() {
      if (currentPage.value == 1) return sensitiveDataConsent.value;
      if (currentPage.value == 2) return clinicalLimitConsent.value;
      return true;
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: LinearProgressIndicator(
                value: (currentPage.value + 1) / steps.length,
                backgroundColor: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => currentPage.value = page,
                children: steps,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _canContinue() 
                          ? () {
                              if (currentPage.value < steps.length - 1) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                _finishOnboarding();
                              }
                            }
                          : null,
                      child: Text(currentPage.value == steps.length - 1 ? 'Empezar' : 'Continuar'),
                    ),
                  ),
                  if (currentPage.value > 0)
                    TextButton(
                      onPressed: () => pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      ),
                      child: Text('Atrás', style: TextStyle(color: colorScheme.onSurfaceVariant)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoStep extends StatelessWidget {
  final String title;
  final String content;
  final IconData image;

  const _InfoStep({required this.title, required this.content, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: 32),
          Text(title, style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text(content, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ConsentStep extends StatelessWidget {
  final String title;
  final String content;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool isRequired;

  const _ConsentStep({
    required this.title,
    required this.content,
    required this.value,
    required this.onChanged,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(content, style: theme.textTheme.bodyMedium),
            ),
          ),
          const SizedBox(height: 32),
          CheckboxListTile(
            value: value,
            onChanged: onChanged,
            title: Text(
              isRequired ? 'Sí, entiendo y autorizo (Requerido)' : 'Sí, autorizo (Opcional)',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isRequired && !value ? theme.colorScheme.error : null,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
