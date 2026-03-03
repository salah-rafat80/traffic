import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A small pill-shaped tag that shows the payment status of a violation.
/// Green background for paid ("مدفوعة"), red for unpaid ("غير مدفوعة").
class ViolationStatusTag extends StatelessWidget {
  /// Whether the violation has been paid.
  final bool isPaid;

  const ViolationStatusTag({super.key, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    final bgColor = isPaid ? const Color(0xFFE8F5E9) : const Color(0xFFFFE9E8);
    final textColor = isPaid
        ? const Color(0xFF27AE60)
        : const Color(0xFFE53935);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        isPaid ? 'مدفوعة' : 'غير مدفوعة',
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
