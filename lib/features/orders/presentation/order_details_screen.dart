import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/service_screen_appbar.dart';
import 'package:traffic/injection_container.dart';
import '../domain/entities/order_model.dart';
import 'widgets/failed_order_alert.dart';
import 'widgets/finalize_order_button.dart';
import 'widgets/order_loading_overlay.dart';
import 'widgets/order_status_timeline.dart';
import 'widgets/order_summary_header_card.dart';

import 'package:traffic/features/orders/presentation/cubits/my_orders_cubit.dart';

import 'cubits/order_details_cubit.dart';
import 'utils/order_details_helper.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailsCubit>(
      create: (_) => getIt<OrderDetailsCubit>(),
      child: _OrderDetailsView(order: order),
    );
  }
}

class _OrderDetailsView extends StatelessWidget {
  final OrderModel order;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _OrderDetailsView({required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderDetailsCubit, OrderDetailsState>(
      listener: (context, state) {
        if (state is OrderDetailsMedicalBookingSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم حجز موعد الكشف الطبي بنجاح! جاري الانتقال لحجز اختبار القيادة...',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Color(0xFF27AE60),
            ),
          );
          OrderDetailsHelper.startPracticalBooking(context, state.requestNumber);
        } else if (state is OrderDetailsPracticalBookingSuccess) {
          try {
            context.read<MyOrdersCubit>().fetchMyOrders();
          } catch (_) {}

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم حجز موعد اختبار القيادة بنجاح! تم استكمال جميع حجز المواعيد.',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Color(0xFF27AE60),
            ),
          );
        } else if (state is OrderDetailsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Stack(
        children: [
          Scaffold(
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
                        OrderSummaryHeaderCard(order: order),
                        if (order.status == OrderStatus.failed ||
                            (order.stepCode ?? '') == 'MEDICAL_EXAM_FAILED' ||
                            order.statusLabel.contains('عدم اجتياز') ||
                            order.statusLabel.contains('راسب') ||
                            order.statusLabel.contains('لم يجتز') ||
                            order.statusLabel.contains('failed') ||
                            order.statusLabel.contains('Failed')) ...[
                          SizedBox(height: 16.h),
                          FailedOrderAlert(statusLabel: order.statusLabel),
                        ],
                        SizedBox(height: 24.h),
                        OrderStatusTimeline(order: order),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                if (OrderDetailsHelper.showFinalizeButton(order))
                  FinalizeOrderButton(
                    label: OrderDetailsHelper.getButtonLabel(order),
                    onPressed: () => OrderDetailsHelper.handleFinalizePressed(context, order),
                  ),
              ],
            ),
          ),
          BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return const OrderLoadingOverlay();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
