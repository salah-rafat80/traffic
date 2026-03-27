import 'package:traffic/features/driving_license/domain/enums/license_status.dart';

/// Vehicle license model used for the violations inquiry sub-feature.
class VehicleLicenseViolationModel {
  final String plateNumber;
  final String vehicleType;
  final String governorate;
  final String trafficUnit;
  final LicenseStatus status;
  final String issueDate;
  final String expiryDate;
  final bool hasUnpaidViolations;

  const VehicleLicenseViolationModel({
    required this.plateNumber,
    required this.vehicleType,
    required this.governorate,
    required this.trafficUnit,
    required this.status,
    required this.issueDate,
    required this.expiryDate,
    this.hasUnpaidViolations = false,
  });

  /// Dummy data for UI development.
  static List<VehicleLicenseViolationModel> get dummyVehicles => const [
        VehicleLicenseViolationModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          governorate: 'الجيزة',
          trafficUnit: 'وحدة مرور الهرم',
          status: LicenseStatus.valid,
          issueDate: '10/6/2015',
          expiryDate: '10/6/2027',
          hasUnpaidViolations: true,
        ),
        VehicleLicenseViolationModel(
          plateNumber: 'أ ب ت ١١٢٢',
          vehicleType: 'ملاكي – تويوتا كورولا',
          governorate: 'الشرقية',
          trafficUnit: 'وحدة مرور العاشر',
          status: LicenseStatus.valid,
          issueDate: '12/3/2020',
          expiryDate: '12/3/2026',
        ),
        VehicleLicenseViolationModel(
          plateNumber: 'م ن و ٩٩٩٩',
          vehicleType: 'ملاكي – كيا سيراتو',
          governorate: 'القاهرة',
          trafficUnit: 'وحدة مرور مدينة نصر',
          status: LicenseStatus.withdrawn,
          issueDate: '5/1/2018',
          expiryDate: '5/1/2024',
        ),
      ];
}
