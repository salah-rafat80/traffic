import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_model.dart';

class OrderItemCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderItemCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: 343.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9F9),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color(0xFFDADADA), width: 1.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFF222222),
                          fontSize: 15.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      _buildStatusBadge(order.status),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.r,
                        color: const Color(0xFF444444),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'التاريخ : ${order.date}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFF444444),
                          fontSize: 10.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color(0xFFDADADA),
              thickness: 1.r,
              height: 1.r,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    _getActionText(order.status),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF27AE60),
                      fontSize: 14.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    final (bgColor, textColor) = switch (status) {
      OrderStatus.pending => (const Color(0xFFA5D4FF), const Color(0xFF3B82F6)),
      OrderStatus.completed => (const Color(0xFFD4ECDE), const Color(0xFF27AE60)),
      OrderStatus.needsData => (const Color(0xFFFFE3CF), const Color(0xFFDD8C50)),
      OrderStatus.awaitingService => (const Color(0xFFA5D4FF), const Color(0xFF3B82F6)),
      OrderStatus.passed => (const Color(0xFFD4ECDE), const Color(0xFF27AE60)),
      OrderStatus.failed => (const Color(0xFFFFE9E9), const Color(0xFFE53935)),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        order.statusLabel,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getActionText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
      case OrderStatus.completed:
      case OrderStatus.awaitingService:
        return 'عرض التفاصيل';
      case OrderStatus.needsData:
      case OrderStatus.passed:
        return 'استكمال الطلب';
      case OrderStatus.failed:
        return 'حجز اعادة الاختبار';
    }
  }
}
