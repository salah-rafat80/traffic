import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traffic/core/constants/colors.dart';

/// Summary card at the top of violations list screen.
/// Shows total violations count, total amount, and last update date.
class ViolationsSummaryCard extends StatelessWidget {
  final int totalViolations;
  final double totalAmount;
  final String lastUpdate;

  const ViolationsSummaryCard({
    super.key,
    required this.totalViolations,
    required this.totalAmount,
    required this.lastUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      width: double.infinity,
      height: 140.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Spacer(),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SummaryItem(
                label12: "",
                label11: " مخالفات",
                label: 'اجمالي المخالفات',
                value: '$totalViolations',
              ),
              _SummaryItem(
                label12: "جنية مصري",
                label11: "",
                label: 'المبلغ الاجمالي المستحق',
                value: '${totalAmount.toInt()} ',
              ),
            ],
          ),
          const Spacer(),
          Text(
            'اخر تحديث:$lastUpdate',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String label12;
  final String label11;
  final String value;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.label12,
    required this.label11,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (label12.isNotEmpty) const SizedBox(width: 2),
            if (label12.isNotEmpty)
              Text(
                label12,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            if (label11.isNotEmpty) const SizedBox(width: 2),

            if (label11.isNotEmpty)
              Text(
                label11,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
