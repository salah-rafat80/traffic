import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import '../../data/models/renewal_vehicle_license_model.dart';
import '../widgets/renewal_vehicle_license_card.dart';
import 'vehicle_technical_inspection_screen.dart';

/// Step 2 – Vehicle selection screen.
/// User picks which vehicle to renew the license for.
class RenewalVehicleSelectionScreen extends StatefulWidget {
  const RenewalVehicleSelectionScreen({super.key});

  @override
  State<RenewalVehicleSelectionScreen> createState() =>
      _RenewalVehicleSelectionScreenState();
}

class _RenewalVehicleSelectionScreenState
    extends State<RenewalVehicleSelectionScreen> {
  int? _selectedIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  RenewalVehicleLicenseModel? get _selected => _selectedIndex != null
      ? RenewalVehicleLicenseModel.dummyVehicles[_selectedIndex!]
      : null;

  bool get _canProceed => _selected?.canRenew ?? false;

  void _onNextPressed() {
    if (_selected == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            VehicleTechnicalInspectionScreen(vehicle: _selected!),
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
              title: 'تجديد رخصة مركبة',
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
                    ...RenewalVehicleLicenseModel.dummyVehicles
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final vehicle = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: RenewalVehicleLicenseCard(
                          vehicle: vehicle,
                          isSelected: _selectedIndex == index,
                          onTap: vehicle.canRenew
                              ? () => setState(() => _selectedIndex = index)
                              : null,
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
