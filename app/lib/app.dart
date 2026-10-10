import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/core/theme/app_theme.dart';
import 'package:sentia2/features/auth/presentation/screens/login_screen.dart';
import 'package:sentia2/features/home/presentation/screens/home_screen.dart';
import 'package:sentia2/features/chat/presentation/screens/chat_screen.dart';
import 'package:sentia2/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:sentia2/core/providers/navigation_provider.dart';
import 'package:sentia2/shared/widgets/rounded_bottom_nav.dart';

class SentIA2App extends StatelessWidget {
  const SentIA2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SentIA2',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // TODO(etapa-1): reemplazar por la preferencia del usuario en Ajustes.
      themeMode: ThemeMode.dark,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainEntryScreen(),
      },
    );
  }
}

class MainEntryScreen extends ConsumerStatefulWidget {
  const MainEntryScreen({super.key});

  @override
  ConsumerState<MainEntryScreen> createState() => _MainEntryScreenState();
}

class _MainEntryScreenState extends ConsumerState<MainEntryScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatScreen(),
    const Center(child: Text('Historial (Próximamente)')),
    const Center(child: Text('Perfil (Próximamente)')),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(mainTabIndexProvider);
    
    // Ocultar la barra si estamos en el Chat (índice 1)
    final bool isChatActive = currentIndex == 1;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: isChatActive 
        ? null
        : RoundedBottomNav(
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(mainTabIndexProvider.notifier).setTab(index);
            },
            items: const [
              (icon: Icons.home_outlined, label: 'Inicio'),
              (icon: Icons.chat_bubble_outline_rounded, label: 'Chat'),
              (icon: Icons.calendar_today_outlined, label: 'Historial'),
              (icon: Icons.person_outline_rounded, label: 'Perfil'),
            ],
          ),
    );
  }
}
