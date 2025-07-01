import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color primary = Color(0xFF1A5C99);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF003B6F);
  static const Color onPrimaryContainer = Color(0xFFCDE5FF);
  static const Color primaryFixed = Color(0xFFA8C5FF);
  static const Color primaryFixedDim = Color(0xFF8DA8D9);
  static const Color onPrimaryFixed = Color(0xFF001E4A);
  static const Color onPrimaryFixedVariant = Color(0xFF003B6F);

  static const Color secondary = Color(0xFF008080);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF004D4D);
  static const Color onSecondaryContainer = Color(0xFFB2DFDB);
  static const Color secondaryFixed = Color(0xFF95F0E8);
  static const Color secondaryFixedDim = Color(0xFF7BCDC4);
  static const Color onSecondaryFixed = Color(0xFF003834);
  static const Color onSecondaryFixedVariant = Color(0xFF004D4D);

  static const Color tertiary = Color(0xFFFFB300);
  static const Color onTertiary = Color(0xFF000000);
  static const Color tertiaryContainer = Color(0xFFB37D00);
  static const Color onTertiaryContainer = Color(0xFFFFEEC2);
  static const Color tertiaryFixed = Color(0xFFFFDCA8);
  static const Color tertiaryFixedDim = Color(0xFFE0C090);
  static const Color onTertiaryFixed = Color(0xFF4D3800);
  static const Color onTertiaryFixedVariant = Color(0xFFB37D00);

  static const Color error = Color(0xFFD32F2F);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFCDD2);
  static const Color onErrorContainer = Color(0xFFB71C1C);

  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceDim = Color(0xFFE9ECEF);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF8F9FA);
  static const Color surfaceContainer = Color(0xFFE9ECEF);
  static const Color surfaceContainerHigh = Color(0xFFDEE2E6);
  static const Color surfaceContainerHighest = Color(0xFFCED4DA);
  static const Color onSurface = Color(0xFF212529);
  static const Color onSurfaceVariant = Color(0xFF495057);

  static const Color outline = Color(0xFFADB5BD);
  static const Color outlineVariant = Color(0xFFDEE2E6);

  static const Color inverseSurface = Color(0xFF343A40);
  static const Color onInverseSurface = Color(0xFFF8F9FA);
  static const Color inversePrimary = Color(0xFFA8C5FF);

  static const Color scrim = Color(0xFF000000);
  static const Color shadow = Color(0xFF000000);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
    ),
    scaffoldBackgroundColor: surface,
  );
}