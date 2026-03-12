import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String? trailingText;
  final bool showDivider;
  final bool hideArrow;

  const SettingsMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailingText,
    this.showDivider = true,
    this.hideArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3FAED),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Icon(icon, color: const Color(0xFF27AE60), size: 18.w),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF222222),
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(child: Spacer()),
                if (trailingText != null) ...[
                  Text(
                    trailingText!,
                    style: TextStyle(
                      color: const Color(0xFF707070),
                      fontSize: 15.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (!hideArrow) SizedBox(width: 8.w),
                ],
                if (!hideArrow)
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    color: const Color(0xFF27AE60),
                    size: 14.w,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1.h,
            thickness: 1.h,
            color: const Color(0xFFDADADA),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}
