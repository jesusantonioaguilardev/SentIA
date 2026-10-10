import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/app.dart';
import 'package:sentia2/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuración de fuentes para evitar que errores de red bloqueen la UI
  AppTheme.configureFonts();

  runApp(
    const ProviderScope(
      child: SentIA2App(),
    ),
  );
}
