import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// The "سداد المخالفات" (Pay Violations) primary action button.
/// Only shown for unpaid violations.
class ViolationPayButton extends StatelessWidget {
  /// Callback invoked when the button is pressed.
  final VoidCallback onPressed;

  /// Optional button label — defaults to "سداد المخالفات".
  final String label;

  const ViolationPayButton({
    super.key,
    required this.onPressed,
    this.label = 'سداد المخالفات',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                borderRadius: BorderRadius.circular(5.r),
              ),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF8F9F9),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
