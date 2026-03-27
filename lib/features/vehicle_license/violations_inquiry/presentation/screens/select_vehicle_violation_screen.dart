import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import '../../../violations_inquiry/data/models/vehicle_license_violation_model.dart';
import '../widgets/vehicle_violation_card.dart';
import 'vehicle_violations_list_screen.dart';

/// Step 1 – Select the vehicle to query violations for.
/// Mirrors [SelectLicenseScreen] from the driving-license violations flow.
class SelectVehicleViolationScreen extends StatefulWidget {
  const SelectVehicleViolationScreen({super.key});

  @override
  State<SelectVehicleViolationScreen> createState() =>
      _SelectVehicleViolationScreenState();
}

class _SelectVehicleViolationScreenState
    extends State<SelectVehicleViolationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<VehicleLicenseViolationModel> _vehicles =
      VehicleLicenseViolationModel.dummyVehicles;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'استعلام عن مخالفات رخصة المركبة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 16.h),
                  Center(
                    child: Text(
                      'تفاصيل رخصة المركبة',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ...List.generate(_vehicles.length, (index) {
                    return VehicleViolationCard(
                      vehicle: _vehicles[index],
                      isSelected: _selectedIndex == index,
                      onTap: () => setState(() => _selectedIndex = index),
                    );
                  }),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
            child: PrimaryButton(
              label: 'عرض المخالفات',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VehicleViolationsListScreen(
                    vehicle: _vehicles[_selectedIndex],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
