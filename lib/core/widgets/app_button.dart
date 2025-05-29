import 'package:flutter/material.dart';

/// Defines the type of button, affecting its appearance and behavior.
enum AppButtonType { primary, secondary, outline, text, emergency }

/// Defines the size of button, controlling its dimensions and text size.
enum AppButtonSize { small, medium, large }

/// A customizable button widget with support for various types, sizes, and states.
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool iconAfterText;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool isActive; // New property to control the active state

  /// Creates an [AppButton] with customizable properties.
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconAfterText = false,
    this.borderRadius,
    this.padding,
    this.isActive = true, // Default value is true
  });

  /// Builds the button UI with dynamic styling based on type and size.
  @override
  Widget build(BuildContext context) {
    // Retrieve theme for consistent styling.
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || isLoading;

    Color backgroundColor;
    Color textColor = Colors.white;
    Color borderColor;

    switch (type) {
      case AppButtonType.primary:
        backgroundColor = theme.primaryColor;
        borderColor = Colors.transparent;
        break;
      case AppButtonType.secondary:
        backgroundColor = theme.colorScheme.secondary;
        borderColor = Colors.transparent;
        break;
      case AppButtonType.outline:
        backgroundColor = Colors.transparent;
        textColor = theme.primaryColor;
        borderColor = theme.primaryColor;
        break;
      case AppButtonType.text:
        backgroundColor = Colors.transparent;
        textColor = theme.primaryColor;
        borderColor = Colors.transparent;
        break;
      case AppButtonType.emergency:
        backgroundColor = Colors.red;
        borderColor = Colors.transparent;
        break;
    }

    // Determine button dimensions and padding based on size.
    double height;
    double fontSize;
    EdgeInsets buttonPadding;

    switch (size) {
      case AppButtonSize.small:
        height = 36.0;
        fontSize = 14.0;
        buttonPadding = padding ?? const EdgeInsets.symmetric(horizontal: 16.0);
        break;
      case AppButtonSize.medium:
        height = 48.0;
        fontSize = 16.0;
        buttonPadding = padding ?? const EdgeInsets.symmetric(horizontal: 24.0);
        break;
      case AppButtonSize.large:
        height = 56.0;
        fontSize = 18.0;
        buttonPadding = padding ?? const EdgeInsets.symmetric(horizontal: 32.0);
        break;
    }

    // Build button content, handling loading state and icon placement.
    Widget buttonContent;

    if (isLoading) {
      // Show loading indicator during loading state.
      buttonContent = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    } else {
      // Arrange icon and text in a row.
      List<Widget> rowChildren = [];

      if (icon != null && !iconAfterText) {
        rowChildren.add(Icon(icon, color: textColor, size: fontSize + 4));
        rowChildren.add(const SizedBox(width: 8));
      }

      rowChildren.add(
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

      if (icon != null && iconAfterText) {
        rowChildren.add(const SizedBox(width: 8));
        rowChildren.add(Icon(icon, color: textColor, size: fontSize + 4));
      }

      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      );
    }

    // Apply greyed-out effect if the button is not active
    if (!isActive) {
      backgroundColor = Colors.grey;
      textColor = Colors.white;
    }

    // Construct the button with Material and InkWell for tap feedback.
    final buttonWidget = Material(
      color: isDisabled
          ? backgroundColor.withValues(alpha: 0.6)
          : backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
      child: InkWell(
        onTap: isDisabled || !isActive ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        splashColor: textColor.withValues(alpha: 0.1),
        highlightColor: textColor.withValues(alpha: 0.05),
        child: Container(
          height: height,
          padding: buttonPadding,
          decoration: BoxDecoration(
            border: type == AppButtonType.outline
                ? Border.all(color: borderColor, width: 2.0)
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
          ),
          child: Center(child: buttonContent),
        ),
      ),
    );

    // Apply full-width constraint if specified.
    return isFullWidth
        ? SizedBox(width: double.infinity, child: buttonWidget)
        : buttonWidget;
  }
}
