import 'package:flutter/material.dart';
import 'package:techwiz/utils/theme_manager.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryLight = Color(0xFF94A3B8);
  static const Color secondaryDark = Color(0xFF475569);

  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF1F5F9);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textTertiaryLight = Color(0xFF94A3B8);
  static const Color inputBackgroundLight = Color(0xFFF8FAFC);
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color dividerLight = Color(0xFFE2E8F0);

  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textTertiaryDark = Color(0xFF64748B);
  static const Color inputBackgroundDark = Color(0xFF334155);
  static const Color cardBackgroundDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF475569);
  static const Color dividerDark = Color(0xFF475569);

  static Color get background =>
      ThemeManager().isDarkMode ? backgroundDark : backgroundLight;
  static Color get surface =>
      ThemeManager().isDarkMode ? surfaceDark : surfaceLight;
  static Color get surfaceVariant =>
      ThemeManager().isDarkMode ? surfaceVariantDark : surfaceVariantLight;
  static Color get textPrimary =>
      ThemeManager().isDarkMode ? textPrimaryDark : textPrimaryLight;
  static Color get textSecondary =>
      ThemeManager().isDarkMode ? textSecondaryDark : textSecondaryLight;
  static Color get textTertiary =>
      ThemeManager().isDarkMode ? textTertiaryDark : textTertiaryLight;
  static Color get inputBackground =>
      ThemeManager().isDarkMode ? inputBackgroundDark : inputBackgroundLight;
  static Color get cardBackground =>
      ThemeManager().isDarkMode ? cardBackgroundDark : cardBackgroundLight;
  static Color get border =>
      ThemeManager().isDarkMode ? borderDark : borderLight;
  static Color get divider =>
      ThemeManager().isDarkMode ? dividerDark : dividerLight;

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

  static const Color shadow = Color(0x1A000000);
  static const Color disabled = Color(0xFFCBD5E1);
  static const Color disabledText = Color(0xFF94A3B8);

  static ColorScheme get lightColorScheme => ColorScheme.light(
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: primaryLight,
    onPrimaryContainer: primaryDark,
    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: secondaryLight,
    onSecondaryContainer: secondaryDark,
    surface: surfaceLight,
    onSurface: textPrimaryLight,
    surfaceVariant: surfaceVariantLight,
    onSurfaceVariant: textSecondaryLight,
    background: backgroundLight,
    onBackground: textPrimaryLight,
    error: error,
    onError: Colors.white,
    errorContainer: errorLight,
    onErrorContainer: error,
    outline: borderLight,
    outlineVariant: gray100,
    shadow: shadow,
  );

  static ColorScheme get darkColorScheme => ColorScheme.dark(
    primary: primaryLight,
    onPrimary: gray900,
    primaryContainer: primaryDark,
    onPrimaryContainer: primaryLight,
    secondary: secondaryLight,
    onSecondary: gray900,
    secondaryContainer: secondaryDark,
    onSecondaryContainer: secondaryLight,
    surface: surfaceDark,
    onSurface: textPrimaryDark,
    surfaceVariant: surfaceVariantDark,
    onSurfaceVariant: textSecondaryDark,
    background: backgroundDark,
    onBackground: textPrimaryDark,
    error: errorLight,
    onError: gray900,
    errorContainer: error,
    onErrorContainer: errorLight,
    outline: borderDark,
    outlineVariant: gray700,
    shadow: const Color(0x33000000),
  );
}
