import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/profile/presentation/widgets/profile_header.dart';
import '../domain/entities/order_model.dart';
import 'order_details_screen.dart';
import 'widgets/order_item_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static const List<OrderModel> _dummyOrders = [
    OrderModel(
      id: 'v123344',
      title: 'تجديد رخصة القيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.pending,
    ),
    OrderModel(
      id: 'v123345',
      title: 'تجديد رخصة القيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.completed,
    ),
    OrderModel(
      id: 'v123346',
      title: 'تجديد رخصة القيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.needsData,
    ),
    OrderModel(
      id: 'v123347',
      title: 'حجز اختبار قيادة',
      date: '25 اكتوبر 2025',
      status: OrderStatus.awaitingAppointment,
    ),
    OrderModel(
      id: 'v123348',
      title: 'اختبار القيادة العملي',
      date: '25 اكتوبر 2025',
      status: OrderStatus.passed,
    ),
    OrderModel(
      id: 'v123349',
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
                return OrderItemCard(order: _dummyOrders[index], onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(order: _dummyOrders[index]),
                      ));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
