import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import '../../data/models/vehicle_license_model.dart';
import '../widgets/vehicle_license_card.dart';
import 'vehicle_license_details_screen.dart';

class VehicleLostLicenseSelectionScreen extends StatefulWidget {
  const VehicleLostLicenseSelectionScreen({super.key});

  @override
  State<VehicleLostLicenseSelectionScreen> createState() =>
      _VehicleLostLicenseSelectionScreenState();
}

class _VehicleLostLicenseSelectionScreenState
    extends State<VehicleLostLicenseSelectionScreen> {
  int? _selectedIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VehicleLicenseModel? get _selectedVehicle => _selectedIndex != null
      ? VehicleLicenseModel.dummyVehicles[_selectedIndex!]
      : null;

  bool get _canProceed =>
      _selectedVehicle != null && !_selectedVehicle!.hasUnpaidViolations;

  void _onNextPressed() {
    if (_selectedVehicle == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VehicleLicenseDetailsScreen(vehicle: _selectedVehicle!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF5F5F5),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            ServiceScreenAppBar(
              title: 'اصدار بدل فاقد / تالف رخصة مركبة',
              onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
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
                    ...VehicleLicenseModel.dummyVehicles.asMap().entries.map((entry) {
                      final index = entry.key;
                      final vehicle = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: VehicleLicenseCard(
                          vehicle: vehicle,
                          isSelected: _selectedIndex == index,
                          onTap: () => setState(() => _selectedIndex = index),
                        ),
                      );
                    }),
                    SizedBox(height: 12.h),
                    PrimaryButton(
                      label: 'التالي',
                      onPressed: _canProceed ? _onNextPressed : null,
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
