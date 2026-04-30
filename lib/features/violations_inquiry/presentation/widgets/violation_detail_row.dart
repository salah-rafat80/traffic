import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A single RTL detail row used inside the violation details card.
///
/// Layout (RTL): [label + value stacked, right-aligned] ... [green icon box]
///
/// [label] is a small gray caption; [value] is the darker bold text below it.
/// [iconAsset] is the SVG asset path rendered inside the green rounded box.
class ViolationDetailRow extends StatelessWidget {
  /// The field label, e.g. "التاريخ والوقت".
  final String label;

  /// The field value, e.g. "01:32 AM , 2/3/2025".
  final String value;

  /// SVG asset path for the icon shown in the green box on the left.
  final String iconAsset;

  const ViolationDetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: 35.w,
          height: 35.w,
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: const Color(0xFFD4ECDE),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: SvgPicture.asset(
            iconAsset,
            colorFilter: const ColorFilter.mode(
              Color(0xFF27AE60),
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // ── Label + Value (right side, RTL) ──
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // textDirection: TextDirection.rtl,
            children: [
              Text(
                label,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF707070),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF222222),
                ),
              ),
            ],
          ),
        ),

        // ── Green icon box (left side) ──
      ],
    );
  }
}
