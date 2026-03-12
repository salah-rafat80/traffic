import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/service_screen_appbar.dart';
import '../domain/entities/order_model.dart';
import 'widgets/order_status_timeline.dart';
import 'widgets/order_summary_header_card.dart';

class OrderDetailsScreen extends StatefulWidget {

  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: "طلباتي",
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16.r,
                right: 16.r,
                top: 24.h,
                bottom: 16.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'تفاصيل الطلب',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  OrderSummaryHeaderCard(order: widget.order),
                  SizedBox(height: 24.h),
                  OrderStatusTimeline(status: widget.order.status),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
