import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/order_model.dart';

class OrderSummaryHeaderCard extends StatelessWidget {
  final OrderModel order;

  const OrderSummaryHeaderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8F9F9),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF27AE60)),
          borderRadius: BorderRadius.circular(5.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OrderStatusBadge(status: order.status),
              Expanded(
                child: Text(
                  order.title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.id,
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: 15.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'رقم الطلب',
                style: TextStyle(
                  color: const Color(0xFF707070),
                  fontSize: 12.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.date,
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: 15.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'تاريخ التقديم',
                style: TextStyle(
                  color: const Color(0xFF707070),
                  fontSize: 12.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _OrderStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case OrderStatus.pending:
        bgColor = const Color(0xFFA5D4FF);
        textColor = const Color(0xFF3B82F6);
        text = 'قيد التنفيذ';
        break;
      case OrderStatus.completed:
        bgColor = const Color(0xFFD4ECDE);
        textColor = const Color(0xFF27AE60);
        text = 'مكتمل';
        break;
      case OrderStatus.needsData:
        bgColor = const Color(0xFFFFDAB9);
        textColor = const Color(0xFFE67E22);
        text = 'بحاجة لبيانات';
        break;
      case OrderStatus.awaitingService:
        bgColor = const Color(0xFFA5D4FF);
        textColor = const Color(0xFF3B82F6);
        text = 'بانتظار الموعد';
        break;
      case OrderStatus.passed:
        bgColor = const Color(0xFFD4ECDE);
        textColor = const Color(0xFF27AE60);
        text = 'ناجح';
        break;
      case OrderStatus.failed:
        bgColor = const Color(0xFFFFCDD2);
        textColor = const Color(0xFFF44336);
        text = 'راسب';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 14.sp,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
