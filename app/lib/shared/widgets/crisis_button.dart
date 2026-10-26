import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/l10n/app_localizations.dart';

/// Botón de ayuda inmediata (escudo, como en el diseño). Debe estar a máximo
/// un toque en chat, voz, resultados de tests y ajustes (docs/08). Zona
/// protegida: no lo ocultes ni lo condiciones.
class CrisisButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IconButton(
      tooltip: l10n.helpCrisisButton,
      icon: const Icon(Icons.shield_outlined),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => context.push(Routes.help),
    );
  }
}
