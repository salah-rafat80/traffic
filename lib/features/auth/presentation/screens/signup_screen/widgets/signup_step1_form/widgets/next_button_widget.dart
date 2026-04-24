import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isValid;
  final double height;
  final bool isLoading;
  final String label;

  const NextButtonWidget({
    super.key,
    required this.onPressed,
    required this.isValid,
    required this.height,
    this.isLoading = false,
    this.label = 'التالي',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isValid && !isLoading) ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: (isValid && !isLoading) ? const Color(0xFF27AE60) : const Color(0xFFBDBDBD),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo',
                  ),
                ),
        ),
      ),
    );
  }
}
