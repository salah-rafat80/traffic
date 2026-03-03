import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Summary card displayed at the top of the violation review screen.
/// Shows total violations count and total amount due.
class ReviewSummaryCard extends StatelessWidget {
  final int totalViolations;
  final double totalAmount;

  const ReviewSummaryCard({
    super.key,
    required this.totalViolations,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: const Color(0xFF27AE60),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // ── Total violations ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'اجمالي المخالفات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '$totalViolations مخالفات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 1,
            height: 40.h,
            color: const Color(0xFFDADADA),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
          ),

          // ── Total amount ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اجمالي المبلغ المستحق',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${totalAmount.toInt()} جنية مصري',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

