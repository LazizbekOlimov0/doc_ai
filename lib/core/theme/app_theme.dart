import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      secondaryContainer: AppColors.lightSecondaryContainer,
      onSecondaryContainer: AppColors.lightOnSecondaryContainer,
      tertiary: AppColors.lightTertiary,
      onTertiary: AppColors.lightOnTertiary,
      tertiaryContainer: AppColors.lightTertiaryContainer,
      onTertiaryContainer: AppColors.lightOnTertiaryContainer,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
      errorContainer: AppColors.lightErrorContainer,
      onErrorContainer: AppColors.lightOnErrorContainer,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineVariant,
      shadow: AppColors.lightShadow,
      scrim: AppColors.lightScrim,
      inverseSurface: AppColors.darkSurface,
      onInverseSurface: AppColors.darkOnSurface,
      inversePrimary: AppColors.darkPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surface,
        elevation: 8,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      secondaryContainer: AppColors.darkSecondaryContainer,
      onSecondaryContainer: AppColors.darkOnSecondaryContainer,
      tertiary: AppColors.darkTertiary,
      onTertiary: AppColors.darkOnTertiary,
      tertiaryContainer: AppColors.darkTertiaryContainer,
      onTertiaryContainer: AppColors.darkOnTertiaryContainer,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
      errorContainer: AppColors.darkErrorContainer,
      onErrorContainer: AppColors.darkOnErrorContainer,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
      shadow: AppColors.darkShadow,
      scrim: AppColors.darkScrim,
      inverseSurface: AppColors.lightSurface,
      onInverseSurface: AppColors.lightOnSurface,
      inversePrimary: AppColors.lightPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surface,
        elevation: 8,
      ),
    );
  }
}
