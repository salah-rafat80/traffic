import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const TermInfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8F9F9),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFFDADADA)),
          borderRadius: BorderRadius.circular(5.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color(0xFF222222),
              fontSize: 15.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color(0xFF707070),
              fontSize: 10.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
