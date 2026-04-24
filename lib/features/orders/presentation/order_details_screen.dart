import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/api/api_client.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/service_screen_appbar.dart';
import '../../driving_license/data/repositories/driving_renewal_repository.dart';
import '../../driving_license/presentation/cubits/driving_renewal_cubit.dart';
import '../../driving_license/presentation/cubits/driving_license_cubit.dart';
import '../../driving_license/data/repositories/driving_license_repository.dart';
import '../../driving_license/presentation/screens/finalize/finalize_driving_license_screen.dart';
import '../../lost_license/presentation/screens/delivery_method_screen.dart';
import '../../profile/data/repositories/profile_repository.dart';
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

  /// Returns true when this order is an approved driving license renewal
  /// that the user can finalize (choose delivery method).
  bool get _showFinalizeButton {
    final bool isSupportedProcedure = widget.order.title.contains('تجديد رخصة') ||
        widget.order.title.contains('تجديد رخصة قيادة') || 
        widget.order.title.contains('إصدار رخصة قيادة');

    // Show the button when the order was accepted/approved but not yet
    // completed. "pending" and "needsData" are the typical states where
    // the backend has approved but the citizen still needs to finalize.
    final bool isActionable = widget.order.status == OrderStatus.pending ||
        widget.order.status == OrderStatus.needsData;

    return isSupportedProcedure && isActionable;
  }

  void _onFinalizePressed() {
    final String requestNumber = widget.order.id.trim();
    if (requestNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تعذر استكمال الطلب: رقم الطلب غير متاح.',
            textDirection: TextDirection.rtl,
          ),
        ),
      );
      return;
    }

    final ApiClient apiClient = ApiClient();
    final String title = widget.order.title;

    if (title.contains('إصدار رخصة قيادة')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<DrivingLicenseCubit>(
            create: (_) => DrivingLicenseCubit(
              repository: DrivingLicenseRepository(apiClient),
              profileRepository: ProfileRepository(apiClient),
            ),
            child: FinalizeDrivingLicenseScreen(
              requestNumber: requestNumber,
            ),
          ),
        ),
      );
    } else if (title.contains('تجديد رخصة')) {
      final DrivingRenewalRepository repository =
          DrivingRenewalRepository(apiClient);
      final DrivingLicenseRenewalDataHandler dataHandler =
          DrivingLicenseRenewalDataHandler(repository);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<DrivingRenewalCubit>(
            create: (_) => DrivingRenewalCubit(
              dataHandler: dataHandler,
              profileRepository: ProfileRepository(apiClient),
            ),
            child: DeliveryMethodScreen.renewalFinalize(
              renewalRequestNumber: requestNumber,
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'لم يتم دعم استكمال هذه الخدمة بعد.',
            textDirection: TextDirection.rtl,
          ),
        ),
      );
    }
  }

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
          if (_showFinalizeButton)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: PrimaryButton(
                label: 'استكمال الإجراءات',
                onPressed: _onFinalizePressed,
                height: 48.h,
              ),
            ),
        ],
      ),
    );
  }
}
