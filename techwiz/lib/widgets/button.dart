import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isLoading;
  final Widget? icon;
  final double fontSize;
  final FontWeight fontWeight;
  final bool enabled;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.isLoading = false,
    this.icon,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine if button should be disabled
    final isDisabled = !enabled || onPressed == null || isLoading;

    // Get colors based on button type and state
    final colors = _getButtonColors(colorScheme, isDisabled);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.foreground,
          disabledBackgroundColor: colors.disabledBackground,
          disabledForegroundColor: colors.disabledForeground,
          elevation: type == ButtonType.primary ? 2 : 0,
          shadowColor: type == ButtonType.primary
              ? colorScheme.shadow
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: colors.border,
              width: type == ButtonType.outline ? 1.5 : 0,
            ),
          ),
          padding: padding,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.foreground,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: colors.foreground,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _ButtonColors _getButtonColors(ColorScheme colorScheme, bool isDisabled) {
    if (isDisabled) {
      return _ButtonColors(
        background: colorScheme.onSurface.withOpacity(0.12),
        foreground: colorScheme.onSurface.withOpacity(0.38),
        border: Colors.transparent,
        disabledBackground: colorScheme.onSurface.withOpacity(0.12),
        disabledForeground: colorScheme.onSurface.withOpacity(0.38),
      );
    }

    switch (type) {
      case ButtonType.primary:
        return _ButtonColors(
          background: backgroundColor ?? colorScheme.primary,
          foreground: textColor ?? colorScheme.onPrimary,
          border: borderColor ?? Colors.transparent,
          disabledBackground: colorScheme.onSurface.withOpacity(0.12),
          disabledForeground: colorScheme.onSurface.withOpacity(0.38),
        );

      case ButtonType.secondary:
        return _ButtonColors(
          background: backgroundColor ?? colorScheme.secondary,
          foreground: textColor ?? colorScheme.onSecondary,
          border: borderColor ?? Colors.transparent,
          disabledBackground: colorScheme.onSurface.withOpacity(0.12),
          disabledForeground: colorScheme.onSurface.withOpacity(0.38),
        );

      case ButtonType.outline:
        return _ButtonColors(
          background: backgroundColor ?? Colors.transparent,
          foreground: textColor ?? colorScheme.primary,
          border: borderColor ?? colorScheme.outline,
          disabledBackground: Colors.transparent,
          disabledForeground: colorScheme.onSurface.withOpacity(0.38),
        );

      case ButtonType.text:
        return _ButtonColors(
          background: backgroundColor ?? Colors.transparent,
          foreground: textColor ?? colorScheme.primary,
          border: borderColor ?? Colors.transparent,
          disabledBackground: Colors.transparent,
          disabledForeground: colorScheme.onSurface.withOpacity(0.38),
        );
    }
  }
}

class _ButtonColors {
  final Color background;
  final Color foreground;
  final Color border;
  final Color disabledBackground;
  final Color disabledForeground;

  _ButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
    required this.disabledBackground,
    required this.disabledForeground,
  });
}
