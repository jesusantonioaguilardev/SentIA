import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/core/security/secure_store.dart';

/// Preferencias de la persona (no sensibles). Se guardan en el almacenamiento
/// seguro para no sumar otra dependencia de almacenamiento.
@immutable
class AppPreferences {
  const new({
    // Oscuro por defecto: preferencia expresada por el equipo (2026-10-10).
    // Cada persona puede cambiarlo en Ajustes.
    this.themeMode = ThemeMode.dark,
    this.textScale = 1,
    this.welcomeSeen = false,
  });

  final ThemeMode themeMode;

  /// Multiplicador sobre el tamaño de texto del sistema (no lo reemplaza).
  final double textScale;

  /// La pantalla de bienvenida ya se mostró una vez.
  final bool welcomeSeen;

  static const minTextScale = 0.85;
  static const maxTextScale = 1.3;

  AppPreferences copyWith({
    ThemeMode? themeMode,
    double? textScale,
    bool? welcomeSeen,
  }) => AppPreferences(
    themeMode: themeMode ?? this.themeMode,
    textScale: textScale ?? this.textScale,
    welcomeSeen: welcomeSeen ?? this.welcomeSeen,
  );
}

class AppPreferencesController extends Notifier<AppPreferences> {
  static const _themeKey = 'prefs.theme_mode';
  static const _textScaleKey = 'prefs.text_scale';
  static const _welcomeKey = 'prefs.welcome_seen';

  SecureStore get _store => ref.read(secureStoreProvider);

  @override
  AppPreferences build() {
    unawaited(_load());
    return const AppPreferences();
  }

  Future<void> _load() async {
    final theme = await _store.read(_themeKey);
    final scale = double.tryParse(await _store.read(_textScaleKey) ?? '');
    final welcome = await _store.read(_welcomeKey);
    if (!ref.mounted) return;
    state = AppPreferences(
      themeMode: ThemeMode.values.asNameMap()[theme] ?? ThemeMode.dark,
      textScale: (scale ?? 1).clamp(
        AppPreferences.minTextScale,
        AppPreferences.maxTextScale,
      ),
      welcomeSeen: welcome == 'true',
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _store.write(_themeKey, mode.name);
  }

  Future<void> setTextScale(double scale) async {
    final clamped = scale.clamp(
      AppPreferences.minTextScale,
      AppPreferences.maxTextScale,
    );
    state = state.copyWith(textScale: clamped);
    await _store.write(_textScaleKey, clamped.toString());
  }

  Future<void> markWelcomeSeen() async {
    state = state.copyWith(welcomeSeen: true);
    await _store.write(_welcomeKey, 'true');
  }
}

final appPreferencesProvider =
    NotifierProvider<AppPreferencesController, AppPreferences>(
      AppPreferencesController.new,
    );
