import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryLight = Color(0xFF94A3B8);
  static const Color secondaryDark = Color(0xFF475569);

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  static const Color success = Color(0xFF059669);
  static const Color successLight = Color(0xFF10B981);
  static const Color warning = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFEF4444);
  static const Color info = Color(0xFF0891B2);
  static const Color infoLight = Color(0xFF06B6D4);

  static const Color gray50 = Color(0xFFF8FAFC);
  static const Color gray100 = Color(0xFFF1F5F9);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E1);
  static const Color gray400 = Color(0xFF94A3B8);
  static const Color gray500 = Color(0xFF64748B);
  static const Color gray600 = Color(0xFF475569);
  static const Color gray700 = Color(0xFF334155);
  static const Color gray800 = Color(0xFF1E293B);
  static const Color gray900 = Color(0xFF0F172A);

  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);

  static const Color shadow = Color(0x1A000000);

  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF8FAFC);
  static const Color disabled = Color(0xFFCBD5E1);
  static const Color disabledText = Color(0xFF94A3B8);

  static ColorScheme get lightColorScheme => const ColorScheme.light(
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: primaryLight,
    onPrimaryContainer: primaryDark,
    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: secondaryLight,
    onSecondaryContainer: secondaryDark,
    surface: surface,
    onSurface: textPrimary,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: textSecondary,
    background: background,
    onBackground: textPrimary,
    error: error,
    onError: Colors.white,
    errorContainer: errorLight,
    onErrorContainer: error,
    outline: border,
    outlineVariant: borderLight,
    shadow: shadow,
  );

  static ColorScheme get darkColorScheme => const ColorScheme.dark(
    primary: primaryLight,
    onPrimary: gray900,
    primaryContainer: primaryDark,
    onPrimaryContainer: primaryLight,
    secondary: secondaryLight,
    onSecondary: gray900,
    secondaryContainer: secondaryDark,
    onSecondaryContainer: secondaryLight,
    surface: gray800,
    onSurface: gray100,
    surfaceVariant: gray700,
    onSurfaceVariant: gray300,
    background: gray900,
    onBackground: gray100,
    error: errorLight,
    onError: gray900,
    errorContainer: error,
    onErrorContainer: errorLight,
    outline: gray600,
    outlineVariant: gray700,
    shadow: Color(0x33000000),
  );
}

extension AppColorsExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  Color get primaryColor => AppColors.primary;
  Color get backgroundColor => AppColors.background;
  Color get textPrimary => AppColors.textPrimary;
  Color get textSecondary => AppColors.textSecondary;
  Color get success => AppColors.success;
  Color get warning => AppColors.warning;
  Color get error => AppColors.error;
  Color get info => AppColors.info;
}
