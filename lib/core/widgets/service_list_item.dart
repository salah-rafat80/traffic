import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// A rounded card row used in service screens (رخصة القيادة, رخصة المركبة).
///
/// Layout (RTL):  [  label text  ←──────→  green icon  ]
class ServiceListItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;

  const ServiceListItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // ── Icon container (right side in RTL) ──
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 30.w,
                  height: 23.h,
                  child: SvgPicture.asset(icon),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // ── Title text ──
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF222222),
                  // height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
