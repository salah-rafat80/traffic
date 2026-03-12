import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/profile/presentation/widgets/profile_header.dart';
import '../domain/entities/order_model.dart';
import 'widgets/order_item_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static const List<OrderModel> _dummyOrders = [
    OrderModel(
      title: 'تجديد رخصة القيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.pending,
    ),
    OrderModel(
      title: 'تجديد رخصة القيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.completed,
    ),
    OrderModel(
      title: 'تجديد رخصة القيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.needsData,
    ),
    OrderModel(
      title: 'حجز اختبار قيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.awaitingAppointment,
    ),
    OrderModel(
      title: 'اختبار القيادة العملي',
      date: '25 اكتوبر 2025',
      status: OrderStatus.passed,
    ),
    OrderModel(
      title: 'اختبار القيادة العملي',
      date: '25 اكتوبر 2025',
      status: OrderStatus.failed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const ProfileHeader(title: 'طلباتي'),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: _dummyOrders.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                return OrderItemCard(
                  order: _dummyOrders[index],
                  onTap: () {
                    // TODO: Navigate to Order Details
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
