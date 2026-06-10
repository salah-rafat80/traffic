import 'package:traffic/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/empty_state_widget.dart';
import 'package:traffic/features/vehicle_license/data/repositories/vehicle_license_repository.dart';
import 'package:traffic/features/vehicle_license/data/models/vehicle_license_model.dart'
    as main_model;
import '../../data/models/vehicle_license_model.dart';
import '../widgets/vehicle_license_card.dart';
import 'vehicle_license_details_screen.dart';
import 'package:traffic/injection_container.dart';

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
  List<main_model.VehicleLicenseModel> _vehicles = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final repository = getIt<VehicleLicenseRepository>();

      // Fetch fresh from API directly
      final result = await repository.getMyLicenses();
      if (result.isSuccess && result.data != null) {
        if (mounted) {
          setState(() {
            _vehicles = result.data!;
            _isLoading = false;
            if (_vehicles.length == 1) {
              _selectedIndex = 0;
            } else {
              _selectedIndex = null;
            }
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = result.error ?? 'فشل تحميل الرخص';
            _selectedIndex = null;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'حدث خطأ غير متوقع';
          _selectedIndex = null;
        });
      }
    }
  }

  String _formatVehicleType(String category, String brand, String model) {
    final cleanCategory = category.trim();
    final cleanBrand = brand.trim();
    final cleanModel = model.trim();

    final brandModel = [cleanBrand, cleanModel]
        .where((s) => s.isNotEmpty)
        .join(' ');

    if (cleanCategory.isNotEmpty && brandModel.isNotEmpty) {
      return '$cleanCategory - $brandModel';
    } else if (cleanCategory.isNotEmpty) {
      return cleanCategory;
    } else {
      return brandModel;
    }
  }

  /// Maps the main VehicleLicenseModel → replacement-flow VehicleLicenseModel.
  VehicleLicenseModel _toReplacementModel(main_model.VehicleLicenseModel v) {
    VehicleLicenseStatus status;
    switch (v.status.name) {
      case 'expired':
        status = VehicleLicenseStatus.expired;
        break;
      case 'withdrawn':
        status = VehicleLicenseStatus.withdrawn;
        break;
      default:
        status = VehicleLicenseStatus.valid;
    }
    return VehicleLicenseModel(
      plateNumber: (v.plateNumber != null && v.plateNumber!.isNotEmpty) ? v.plateNumber! : v.vehicleLicenseNumber,
      vehicleType: _formatVehicleType(v.category, v.brand, v.model),
      expiryDate: v.expiryDate,
      status: status,
      hasUnpaidViolations: v.hasUnpaidViolations,
    );
  }

  VehicleLicenseModel? get _selectedVehicle => _selectedIndex != null
      ? _toReplacementModel(_vehicles[_selectedIndex!])
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
    return Scaffold(
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

                  if (_isLoading)
                    Center(child: CustomLoadingIndicator())
                  else if (_errorMessage != null)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          Icon(
                            _errorMessage!.contains('اتصال')
                                ? Icons.wifi_off_rounded
                                : Icons.error_outline_rounded,
                            size: 64.r,
                            color: const Color(0xFFE74C3C),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF555555),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton.icon(
                            onPressed: _loadVehicles,
                            icon: const Icon(
                              Icons.refresh_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              'إعادة المحاولة',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF27AE60),
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    )
                  else if (_vehicles.isEmpty)
                    const EmptyStateWidget(
                      message: 'لا توجد رخص مركبات مسجلة حالياً',
                    )
                  else
                    ..._vehicles.asMap().entries.map((entry) {
                      final index = entry.key;
                      final model = _toReplacementModel(entry.value);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: VehicleLicenseCard(
                          vehicle: model,
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
    );
  }
}
