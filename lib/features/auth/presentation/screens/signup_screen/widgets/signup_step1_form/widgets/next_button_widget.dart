import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isValid;
  final double height;

  const NextButtonWidget({
    super.key,
    required this.onPressed,
    required this.isValid,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isValid ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isValid ? const Color(0xFF27AE60) : const Color(0xFFBDBDBD),
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
    );
  }
}
