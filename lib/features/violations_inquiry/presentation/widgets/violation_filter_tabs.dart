import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Toggle tabs to filter violations by paid/unpaid status.
/// Two buttons: "مدفوعة" and "غير مدفوعة".
class ViolationFilterTabs extends StatelessWidget {
  final bool showPaid;
  final ValueChanged<bool> onChanged;

  const ViolationFilterTabs({
    super.key,
    required this.showPaid,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: _TabButton(
              label: 'غير مدفوعة',
              isActive: !showPaid,
              onTap: () => onChanged(false),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _TabButton(
              label: 'مدفوعة',
              isActive: showPaid,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUnpaid = label == 'غير مدفوعة';

    // Active colors based on tab type
    final Color activeBg = isUnpaid
        ? const Color(0xFFFDE8E8) // Light red bg for unpaid
        : const Color(0xff34A853); // Green bg for paid
    final Color activeBorder = isUnpaid
        ? const Color(0xFFE53935) // Red border for unpaid
        : const Color(0xff34A853); // Green border for paid
    final Color activeText = isUnpaid
        ? const Color(0xFFE53935) // Red text for unpaid
        : Colors.white; // White text for paid

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Container(
          height: 40.h,
          width: 172.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? activeBg : const Color(0xffD9D9D9),
            borderRadius: BorderRadius.circular(10.r),
            border: isActive
                ? Border.all(color: activeBorder, width: 1.5)
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? activeText : const Color(0xFF888888),
            ),
          ),
        ),
      ),
    );
  }
}
