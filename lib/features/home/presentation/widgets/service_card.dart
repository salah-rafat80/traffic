import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// A tall service card with icon on top and label below,
/// used in the "الخدمات" grid section.
class ServiceCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;
  final bool isAssistant;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isAssistant = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: isAssistant
            ? _AssistantContent(icon: icon, title: title)
            : _ServiceContent(icon: icon, title: title),
      ),
    );
  }
}

class _ServiceContent extends StatelessWidget {
  final String icon;
  final String title;
  const _ServiceContent({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon, width: 38.w, height: 38.w),
        SizedBox(height: 12.h),
        Text(
          title,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}

class _AssistantContent extends StatelessWidget {
  final String icon;
  final String title;
  const _AssistantContent({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        SvgPicture.asset(icon, width: 28.w, height: 28.w),
        SizedBox(width: 10.w),
        Text(
          title,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}

