// path: lib/features/home/presentation/widgets/home_search_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 14.sp,
          color: const Color(0xFF1A1A1A),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'ما الخدمة التي تريدها؟',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 14.sp,
            color: const Color(0xFFAAAAAA),
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Icon(
              Icons.search,
              color: const Color(0xFF9CA3AF),
              size: 22.sp,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minHeight: 22.sp,
            minWidth: 34.w,
          ),
        ),
      ),
    );
  }
}
