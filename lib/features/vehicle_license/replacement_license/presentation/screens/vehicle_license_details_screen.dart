import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import '../../data/models/vehicle_license_model.dart';
import '../widgets/vehicle_license_card.dart';
import 'vehicle_replacement_type_selection_screen.dart';

class VehicleLicenseDetailsScreen extends StatefulWidget {
  final VehicleLicenseModel vehicle;

  const VehicleLicenseDetailsScreen({super.key, required this.vehicle});

  @override
  State<VehicleLicenseDetailsScreen> createState() => _VehicleLicenseDetailsScreenState();
}

class _VehicleLicenseDetailsScreenState extends State<VehicleLicenseDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onNextPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VehicleReplacementTypeSelectionScreen(vehicle: widget.vehicle),
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
                    VehicleLicenseCard(
                      vehicle: widget.vehicle,
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
