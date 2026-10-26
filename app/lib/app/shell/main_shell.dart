import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentia2/core/responsive/responsive_layout.dart';
import 'package:sentia2/l10n/app_localizations.dart';
import 'package:sentia2/shared/widgets/rounded_bottom_nav.dart';

/// Contenedor de las pestañas principales. Bottom navigation en teléfono,
/// navigation rail en tablet (docs/04 §Responsive).
class MainShell extends StatelessWidget {
  const new({required this.shell, super.key});

  final StatefulNavigationShell shell;

  /// Índice de la rama de chat: en teléfono oculta la barra para dar espacio.
  static const _chatBranch = 1;

  void _goTo(int index) =>
      shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destinations = [
      (icon: Icons.home_outlined, label: l10n.navHome),
      (icon: Icons.chat_bubble_outline_rounded, label: l10n.navChat),
      (icon: Icons.calendar_today_outlined, label: l10n.navHistory),
      (icon: Icons.person_outline_rounded, label: l10n.navProfile),
    ];

    return ResponsiveLayout(
      compact: (_) => Scaffold(
        extendBody: true,
        body: shell,
        bottomNavigationBar: shell.currentIndex == _chatBranch
            ? null
            : RoundedBottomNav(
                currentIndex: shell.currentIndex,
                onTap: _goTo,
                items: destinations,
              ),
      ),
      medium: (_) => Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                selectedIndex: shell.currentIndex,
                onDestinationSelected: _goTo,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final d in destinations)
                    NavigationRailDestination(
                      icon: Icon(d.icon),
                      label: Text(d.label),
                    ),
                ],
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: shell),
          ],
        ),
      ),
    );
  }
}
