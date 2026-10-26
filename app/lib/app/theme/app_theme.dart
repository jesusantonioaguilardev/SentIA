import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentia2/app/theme/app_colors.dart';
import 'package:sentia2/app/theme/sentia_colors.dart';
import 'package:sentia2/app/theme/tokens.dart';

/// Tema "Serena & Calma" (docs/design/DESIGN.md): superficies tonales, formas
/// de píldora, Plus Jakarta Sans y pesos medios en lugar de negritas.
abstract final class AppTheme {
  // Si falla la descarga de la fuente, se usa la del sistema.
  // TODO(etapa-1): empaquetar la fuente (OFL) para no depender de la red.
  static void configureFonts() {
    GoogleFonts.config.allowRuntimeFetching = true;
  }

  static ThemeData get light => _build(
    const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      primaryFixed: AppColors.primaryFixed,
      inversePrimary: AppColors.inversePrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      tertiaryFixed: AppColors.tertiaryFixed,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      surfaceDim: AppColors.surfaceDim,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.onInverseSurface,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      shadow: AppColors.slate,
      surfaceTint: Colors.transparent,
    ),
    SentiaColors.light,
  );

  static ThemeData get dark => _build(
    const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColorsDark.primary,
      onPrimary: AppColorsDark.onPrimary,
      primaryContainer: AppColorsDark.primaryContainer,
      onPrimaryContainer: AppColorsDark.onPrimaryContainer,
      primaryFixed: AppColorsDark.primaryFixed,
      secondary: AppColorsDark.secondary,
      onSecondary: AppColorsDark.onSecondary,
      secondaryContainer: AppColorsDark.secondaryContainer,
      onSecondaryContainer: AppColorsDark.onSecondaryContainer,
      tertiary: AppColorsDark.tertiary,
      onTertiary: AppColorsDark.onTertiary,
      tertiaryContainer: AppColorsDark.tertiaryContainer,
      onTertiaryContainer: AppColorsDark.onTertiaryContainer,
      error: AppColorsDark.error,
      onError: AppColorsDark.onError,
      errorContainer: AppColorsDark.errorContainer,
      onErrorContainer: AppColorsDark.onErrorContainer,
      surface: AppColorsDark.surface,
      surfaceContainerLowest: AppColorsDark.surfaceContainerLowest,
      surfaceContainerLow: AppColorsDark.surfaceContainerLow,
      surfaceContainer: AppColorsDark.surfaceContainer,
      surfaceContainerHigh: AppColorsDark.surfaceContainerHigh,
      surfaceContainerHighest: AppColorsDark.surfaceContainerHighest,
      onSurface: AppColorsDark.onSurface,
      onSurfaceVariant: AppColorsDark.onSurfaceVariant,
      outline: AppColorsDark.outline,
      outlineVariant: AppColorsDark.outlineVariant,
      shadow: Colors.black,
      surfaceTint: Colors.transparent,
    ),
    SentiaColors.dark,
  );

  /// Escala tipográfica del diseño mapeada a Material 3 (tamaños de móvil).
  static TextTheme _textTheme(Color color) {
    TextStyle style(
      double size,
      double height,
      FontWeight weight, [
      double letterSpacingEm = 0,
    ]) => TextStyle(
      fontSize: size,
      height: height / size,
      fontWeight: weight,
      letterSpacing: letterSpacingEm * size,
      color: color,
    );

    const regular = FontWeight.w400;
    const medium = FontWeight.w500;
    const semibold = FontWeight.w600;

    return GoogleFonts.plusJakartaSansTextTheme(
      TextTheme(
        displayLarge: style(40, 48, semibold, -0.02), // headline-xl
        displayMedium: style(32, 40, semibold, -0.015), // headline-lg
        displaySmall: style(30, 38, semibold, -0.015), // headline-xl-mobile
        headlineLarge: style(30, 38, semibold, -0.015),
        headlineMedium: style(24, 32, semibold, -0.01), // headline-lg-mobile
        headlineSmall: style(20, 28, semibold, -0.01), // headline-md
        titleLarge: style(20, 28, semibold, -0.01),
        titleMedium: style(17, 24, semibold), // headline-sm
        titleSmall: style(15, 20, medium, 0.01), // label-lg
        bodyLarge: style(18, 28, regular), // body-lg
        bodyMedium: style(15, 24, regular), // body-md
        bodySmall: style(13, 20, regular, 0.01), // body-sm
        labelLarge: style(15, 20, medium, 0.01), // label-lg
        labelMedium: style(13, 18, medium, 0.02), // label-md
        labelSmall: style(11, 14, semibold, 0.04), // label-sm
      ),
    );
  }

  static ThemeData _build(ColorScheme colors, SentiaColors extra) {
    final text = _textTheme(colors.onSurface);
    const pill = StadiumBorder();
    const buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    const buttonMinSize = Size(A11y.minTouchTarget, A11y.minTouchTarget);

    // Botón primario: píldora sobre primary-container (#3A6B88 en claro).
    final primaryButton = FilledButton.styleFrom(
      backgroundColor: colors.primaryContainer,
      foregroundColor: colors.brightness == Brightness.light
          ? colors.onPrimary
          : colors.onPrimaryContainer,
      disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.12),
      textStyle: text.labelLarge,
      padding: buttonPadding,
      minimumSize: buttonMinSize,
      shape: pill,
      elevation: 0,
    );

    OutlineInputBorder inputBorder([BorderSide side = BorderSide.none]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.base),
          borderSide: side,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      textTheme: text,
      extensions: [extra],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: colors.onSurface,
        titleTextStyle: text.titleMedium,
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          side: BorderSide(color: extra.hairline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(style: primaryButton),
      // Las pantallas heredadas usan ElevatedButton: mismo estilo primario.
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
      // Secundario: píldora tonal sin borde, texto primario.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.surfaceContainerLow,
          foregroundColor: colors.onSurface,
          side: BorderSide.none,
          textStyle: text.labelLarge,
          padding: buttonPadding,
          minimumSize: buttonMinSize,
          shape: pill,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: text.labelMedium,
          minimumSize: buttonMinSize,
          shape: pill,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(minimumSize: buttonMinSize),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: 14,
        ),
        hintStyle: text.bodyMedium?.copyWith(color: colors.outline),
        labelStyle: text.labelMedium,
        prefixIconColor: colors.outline,
        suffixIconColor: colors.outline,
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(
          BorderSide(color: colors.primaryContainer, width: 1.5),
        ),
        errorBorder: inputBorder(BorderSide(color: colors.error)),
        focusedErrorBorder: inputBorder(
          BorderSide(color: colors.error, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: pill,
        side: BorderSide(color: extra.hairline),
        backgroundColor: colors.surfaceContainerLowest,
        selectedColor: extra.calmContainer,
        labelStyle: text.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: colors.onSurfaceVariant, width: 1.5),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface.withValues(alpha: 0.85),
        indicatorColor: colors.primaryFixed,
        labelTextStyle: WidgetStatePropertyAll(text.labelSmall),
        elevation: 0,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surface,
        indicatorColor: colors.primaryFixed,
        selectedLabelTextStyle: text.labelSmall,
        unselectedLabelTextStyle: text.labelSmall,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.base),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.lg)),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.lg),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.surfaceContainerHigh,
        thickness: 1,
      ),
    );
  }
}
