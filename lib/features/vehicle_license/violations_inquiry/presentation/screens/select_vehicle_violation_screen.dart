import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/vehicle_license/violations_inquiry/data/models/vehicle_license_violation_model.dart';
import 'package:traffic/features/vehicle_license/violations_inquiry/data/repositories/vehicle_violation_license_repository.dart';
import '../widgets/vehicle_violation_card.dart';
import 'vehicle_violations_list_screen.dart';

/// Step 1 – Select the vehicle to query violations for.
/// Loads real data from GET /VehicleLicense/my-licenses using cache-first strategy,
/// mirroring [SelectLicenseScreen] from the driving-license violations flow.
class SelectVehicleViolationScreen extends StatefulWidget {
  const SelectVehicleViolationScreen({super.key});

  @override
  State<SelectVehicleViolationScreen> createState() =>
      _SelectVehicleViolationScreenState();
}

class _SelectVehicleViolationScreenState
    extends State<SelectVehicleViolationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<VehicleLicenseViolationModel> _vehicles = [];
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() => _isLoading = true);
    try {
      final repository = VehicleViolationLicenseRepository(ApiClient());

      // Cache-first: show cached data immediately, then refresh in background
      final cached = await repository.getLocalLicenses();
      if (cached.isNotEmpty) {
        setState(() {
          _vehicles = cached;
          _isLoading = false;
        });
        // Soft background refresh
        final result = await repository.getMyLicenses();
        if (result.isSuccess && result.data != null) {
          await repository.saveLicensesLocal(result.data!);
          if (mounted) {
            setState(() => _vehicles = result.data!);
          }
        }
        return;
      }

      // No cache: fetch from API
      final result = await repository.getMyLicenses();
      if (result.isSuccess && result.data != null) {
        await repository.saveLicensesLocal(result.data!);
        if (mounted) {
          setState(() {
            _vehicles = result.data!;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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

                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_vehicles.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'لا يوجد رخص مركبات مسجلة حالياً',
                          style: TextStyle(fontFamily: 'Tajawal'),
                        ),
                      ),
                    )
                  else
                    ...List.generate(_vehicles.length, (index) {
                      return VehicleViolationCard(
                        vehicle: _vehicles[index],
                        isSelected: _selectedIndex == index,
                        onTap: () =>
                            setState(() => _selectedIndex = index),
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
              onPressed: _isLoading || _vehicles.isEmpty
                  ? null
                  : () => Navigator.push(
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
