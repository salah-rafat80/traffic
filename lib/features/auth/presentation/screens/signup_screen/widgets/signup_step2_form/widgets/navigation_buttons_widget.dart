import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationButtonsWidget extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onPreviousPressed;
  final bool isValid;
  final double buttonHeight;

  const NavigationButtonsWidget({
    super.key,
    required this.onNextPressed,
    required this.onPreviousPressed,
    required this.isValid,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Next button
        Expanded(
          child: InkWell(
            onTap: isValid ? onNextPressed : null,
            child: Container(
              height: buttonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: isValid
                    ? const Color(0xFF27AE60)
                    : const Color(0xFFBDBDBD),
              ),
              child: Center(
                child: Text(
                  'التالي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Previous button
        Expanded(
          child: SizedBox(
            height: buttonHeight,
            child: OutlinedButton(
              onPressed: onPreviousPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF27AE60),
                side: const BorderSide(color: Color(0xFF27AE60)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'السابق',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
