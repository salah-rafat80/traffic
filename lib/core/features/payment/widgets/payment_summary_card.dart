import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/payment/models/payment_intent.dart';
import 'package:traffic/core/widgets/info_row_item.dart';

/// A reusable card that displays the high-level payment summary.
/// Refactored from the Figma "ملخص الدفع" section.
class PaymentSummaryCard extends StatelessWidget {
  final PaymentIntent paymentIntent;

  const PaymentSummaryCard({super.key, required this.paymentIntent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: const Color(0xFFDADADA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: TextDirection.rtl,

        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Text(
              'ملخص الدفع',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF222222),
              ),
            ),
          ),
          Divider(height: 1.h, thickness: 1.h, color: const Color(0xFFDADADA)),
          InfoRowItem(
            label: 'اجمالي السداد',
            value: paymentIntent.formattedTotal,
          ),
          InfoRowItem(
            label: 'نوع الطلب',
            value: paymentIntent.orderType,
            showDivider: false, // Last item has no divider
          ),
        ],
      ),
    );
  }
}
