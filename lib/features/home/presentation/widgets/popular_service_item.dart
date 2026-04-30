// path: lib/features/home/presentation/widgets/popular_service_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularServiceItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;

  const PopularServiceItem({
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
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.lerp(Colors.white, const Color(0xFF3FB678), 0.20)!,
              Color.lerp(Colors.white, const Color(0xFFD3FFE9), 0.15)!,
            ],
            stops: const [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(7.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  height: 45.h,
                  width: 45.h,
                  // padding: EdgeInsets.all(10.w),
                  child: SvgPicture.asset(
                    icon,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cairo(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF222222),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
