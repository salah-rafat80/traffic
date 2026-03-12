import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/checkout/models/order_summary.dart';
import 'package:traffic/core/widgets/info_row_item.dart';

/// Displays the high-level order summary (type, payment method, order ID).
class OrderSummaryCard extends StatelessWidget {
  final OrderSummary summary;

  const OrderSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return _OrderCardShell(
      title: 'ملخص الطلب',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoRowItem(label: 'نوع الطلب', value: summary.orderType),
          InfoRowItem(label: 'طريقة السداد', value: summary.paymentMethod),
          InfoRowItem(
            label: 'رقم الطلب',
            value: summary.orderId,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

// ── Private card shell (scoped to this file) ─────────────────────────────────

class _OrderCardShell extends StatelessWidget {
  final String title;
  final Widget child;

  const _OrderCardShell({required this.title, required this.child});

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                title,
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
          child,
        ],
      ),
    );
  }
}
