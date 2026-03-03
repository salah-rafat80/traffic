import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shared AppBar for service screens (رخصة القيادة, رخصة المركبة, المساعد الذكي).
///
/// Layout (RTL):
///   [← back arrow]  [title centered]  [☰ hamburger]
class ServiceScreenAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const ServiceScreenAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: EdgeInsets.only(top: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              // ── Back arrow (right side in RTL) ──
              GestureDetector(
                onTap: onBackPressed ?? () => Navigator.pop(context),
                child: SvgPicture.asset(
                  'assets/weui_arrow-filled.svg',
                  width: 24.w,
                  height: 24.w,
                ),
              ),

              // ── Title (centered) ──
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ),

              // ── Hamburger menu (left side in RTL) ──
              GestureDetector(
                onTap: onMenuPressed,
                child: Icon(
                  Icons.menu,
                  size: 24.w,
                  color: const Color(0xFF222222),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
