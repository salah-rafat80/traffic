import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/checkout/models/fees_details.dart';
import 'package:traffic/core/widgets/info_row_item.dart';

/// Dynamically renders a list of fee rows and highlights the total in green.
class FeesDetailsCard extends StatelessWidget {
  final FeesDetails fees;

  const FeesDetailsCard({super.key, required this.fees});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFDADADA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header ───────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                'تفاصيل الرسوم',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF222222),
                ),
              ),
            ),
          ),
          Divider(height: 1.h, thickness: 1.h, color: const Color(0xFFDADADA)),

          // ── Fee rows ─────────────────────────────────────────────────────
          ...fees.items.asMap().entries.map((entry) {
            final bool isLast = entry.key == fees.items.length - 1;
            return InfoRowItem(
              label: entry.value.label,
              value: entry.value.amount,
              showDivider: !isLast,
            );
          }),

          // ── Total footer ─────────────────────────────────────────────────
          _TotalFooter(total: fees.total),
        ],
      ),
    );
  }
}

// ── Private widgets ───────────────────────────────────────────────────────────

class _TotalFooter extends StatelessWidget {
  final String total;
  const _TotalFooter({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD4ECDE),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label – right (RTL start)
          Text(
            'اجمالي الرسوم',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF222222),
            ),
          ),
          // Amount – left (RTL end), highlighted in green
          Text(
            total,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF27AE60),
            ),
          ),
        ],
      ),
    );
  }
}
