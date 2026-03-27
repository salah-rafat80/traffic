import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import '../../data/models/vehicle_license_model.dart';
import '../widgets/vehicle_license_card.dart';
import 'vehicle_replacement_type_selection_screen.dart';

class VehicleLicenseDetailsScreen extends StatelessWidget {
  final VehicleLicenseModel vehicle;

  const VehicleLicenseDetailsScreen({super.key, required this.vehicle});

  void _onNextPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VehicleReplacementTypeSelectionScreen(vehicle: vehicle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            const ServiceScreenAppBar(title: 'اصدار بدل فاقد / تالف رخصة مركبة'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'تفاصيل رخصة المركبة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    VehicleLicenseCard(
                      vehicle: vehicle,
                      isSelected: true,
                    ),
                    SizedBox(height: 24.h),
                    PrimaryButton(
                      label: 'التالي',
                      onPressed: () => _onNextPressed(context),
                      height: 48.h,
                      backgroundColor: const Color(0xFF27AE60),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
