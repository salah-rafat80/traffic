import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable primary action button with consistent styling.
/// Used across the app for main actions like "التالي", "حفظ", etc.
class PrimaryButton extends StatelessWidget {
  /// The button label text
  final String label;

  /// Callback invoked when the button is pressed
  final VoidCallback? onPressed;

  /// Optional custom background color (defaults to green #2E7D32)
  final Color? backgroundColor;

  /// Optional custom text color (defaults to white)
  final Color? textColor;

  /// Optional custom disabled background color (defaults to grey #BDBDBD)
  final Color? disabledBackgroundColor;

  /// Optional custom disabled text color (defaults to white70)
  final Color? disabledTextColor;

  /// Optional custom height (defaults to 52.h)
  final double? height;

  /// Optional custom font size (defaults to 17.sp)
  final double? fontSize;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    final Color currentBackgroundColor = isEnabled
        ? (backgroundColor ?? const Color(0xFF2E7D32))
        : (disabledBackgroundColor ?? const Color(0xFFBDBDBD));
    final Color currentTextColor = isEnabled
        ? (textColor ?? Colors.white)
        : (disabledTextColor ?? Colors.white70);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        height: height ?? 52.h,
        decoration: BoxDecoration(
          color: currentBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: fontSize ?? 18.sp,
                fontWeight: FontWeight.w600,
                color: currentTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

