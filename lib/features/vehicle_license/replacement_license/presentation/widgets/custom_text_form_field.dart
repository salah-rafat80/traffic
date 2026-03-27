import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ── Constants ─────────────────────────────────────────────────────────────────

const Color _kBorderDefault = Color(0xFFDADADA);
const Color _kBorderFocused = Color(0xFF27AE60);
const Color _kBorderError = Color(0xFFE53935);
const Color _kHintColor = Color(0xFFAEAEAE);
const Color _kLabelColor = Color(0xFF222222);
const Color _kTextColor = Color(0xFF222222);
const Color _kFillColor = Color(0xFFFAFAFA);
const Color _kErrorTextColor = Color(0xFFE53935);

// ── Widget ────────────────────────────────────────────────────────────────────

/// A styled Arabic [TextFormField] used inside [Form] widgets.
class CustomTextFormField extends StatelessWidget {
  /// Field label shown above the input box.
  final String labelText;

  /// Placeholder text shown inside the input box when empty.
  final String hintText;

  /// Controller that holds the field's current value.
  final TextEditingController controller;

  /// Validator callback; return a non-null string to show an error.
  final FormFieldValidator<String>? validator;

  /// Minimum visible lines (default 1). Set > 1 for multiline/textarea.
  final int minLines;

  /// Maximum lines before scrolling (default 1). Set null for unlimited.
  final int? maxLines;

  /// Keyboard type (default [TextInputType.text]).
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Label ───────────────────────────────────────────────────────────
        Text(
          labelText,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: _kLabelColor,
          ),
        ),

        SizedBox(height: 8.h),

        // ── Input ────────────────────────────────────────────────────────────
        TextFormField(
          controller: controller,
          validator: validator,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: _kTextColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: _kHintColor,
            ),
            errorStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: _kErrorTextColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            filled: true,
            fillColor: _kFillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: _kBorderDefault,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: _kBorderFocused,
                width: 1.5.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: _kBorderError,
                width: 1.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: _kBorderError,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
