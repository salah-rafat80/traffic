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
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case OrderStatus.pending:
        bgColor = const Color(0xFFA5D4FF);
        textColor = const Color(0xFF3B82F6);
        text = 'قيد التنفيذ';
      case OrderStatus.completed:
        bgColor = const Color(0xFFD4ECDE);
        textColor = const Color(0xFF27AE60);
        text = 'مكتمل';
      case OrderStatus.needsData:
        bgColor = const Color(0xFFFFE3CF);
        textColor = const Color(0xFFDD8C50);
        text = 'مطلوب استكمال البيانات';
      case OrderStatus.awaitingService:
        bgColor = const Color(0xFFA5D4FF);
        textColor = const Color(0xFF3B82F6);
        text = 'بانتظار الموعد';
      case OrderStatus.passed:
        bgColor = const Color(0xFFD4ECDE);
        textColor = const Color(0xFF27AE60);
        text = 'تم اجتياز الاختبار';
      case OrderStatus.failed:
        bgColor = const Color(0xFFFFE9E9);
        textColor = const Color(0xFFE53935);
        text = 'لم يتم الاجتياز';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
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
