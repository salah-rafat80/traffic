import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/vehicle_license/data/models/vehicle_license_model.dart';
import 'package:traffic/features/vehicle_license/data/repositories/vehicle_license_repository.dart';
import '../../data/models/renewal_vehicle_license_model.dart';
import '../widgets/renewal_vehicle_license_card.dart';
import 'vehicle_technical_inspection_screen.dart';

/// Step 2 – Vehicle selection screen.
/// Loads real data from GET /VehicleLicense/my-licenses using cache-first strategy.
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
  List<VehicleLicenseModel> _vehicles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() => _isLoading = true);
    try {
      final repository = VehicleLicenseRepository(ApiClient());

      // Cache-first: show cached data immediately, then refresh in background
      final cached = await repository.getLocalLicenses();
      if (cached.isNotEmpty) {
        setState(() {
          _vehicles = cached;
          _isLoading = false;
        });
        final result = await repository.getMyLicenses();
        if (result.isSuccess && result.data != null) {
          await repository.saveLicensesLocal(result.data!);
          if (mounted) setState(() => _vehicles = result.data!);
        }
        return;
      }

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

  /// Maps VehicleLicenseModel status to RenewalLicenseStatus for the card widget.
  RenewalVehicleLicenseModel _toRenewalModel(VehicleLicenseModel v) {
    RenewalLicenseStatus renewalStatus;
    switch (v.status.name) {
      case 'expired':
        renewalStatus = RenewalLicenseStatus.expired;
        break;
      case 'withdrawn':
        renewalStatus = RenewalLicenseStatus.withdrawn;
        break;
      default:
        renewalStatus = RenewalLicenseStatus.valid;
    }
    return RenewalVehicleLicenseModel(
      plateNumber: v.vehicleLicenseNumber,
      vehicleType: '${v.category} – ${v.brand} ${v.model}',
      expiryDate: v.expiryDate,
      status: renewalStatus,
      hasUnpaidViolations: v.hasUnpaidViolations,
    );
  }

  RenewalVehicleLicenseModel? get _selectedModel =>
      _selectedIndex != null ? _toRenewalModel(_vehicles[_selectedIndex!]) : null;

  bool get _canProceed => _selectedModel?.canRenew ?? false;

  void _onNextPressed() {
    if (_selectedModel == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VehicleTechnicalInspectionScreen(vehicle: _selectedModel!),
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
                      ..._vehicles.asMap().entries.map((entry) {
                        final index = entry.key;
                        final model = _toRenewalModel(entry.value);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: RenewalVehicleLicenseCard(
                            vehicle: model,
                            isSelected: _selectedIndex == index,
                            onTap: model.canRenew
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
