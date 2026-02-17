import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const PasswordRequirementItem({
    super.key,
    required this.text,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 20.r,
            color: isMet ? const Color(0xFF27AE60) : const Color(0xFFBDBDBD),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isMet ? Colors.black : const Color(0xFF666666),
                fontFamily: 'Tajawal',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
