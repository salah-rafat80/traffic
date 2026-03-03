import 'package:traffic/features/driving_license/domain/enums/license_status.dart';

class DrivingLicenseModel {
  final String licenseNumber;
  final String licenseType;
  final String governorate;
  final String licensingUnit;
  final LicenseStatus status;
  final String issueDate;
  final String expiryDate;
  final bool hasUnpaidViolations;

  const DrivingLicenseModel({
    required this.licenseNumber,
    required this.licenseType,
    required this.governorate,
    required this.licensingUnit,
    required this.status,
    required this.issueDate,
    required this.expiryDate,
    this.hasUnpaidViolations = false,
  });

  /// Dummy data for UI development
  static List<DrivingLicenseModel> get dummyLicenses => const [
    DrivingLicenseModel(
      licenseNumber: '11223344556677',
      licenseType: 'خاصة',
      governorate: 'الجيزة',
      licensingUnit: 'وحدة مرور الدقي',
      status: LicenseStatus.withdrawn,
      issueDate: '10/6/2015',
      expiryDate: '10/6/2021',
    ),
    DrivingLicenseModel(
      licenseNumber: '12345678901234',
      licenseType: 'خاصة',
      governorate: 'الشرقية',
      licensingUnit: 'وحدة مرور العاشر',
      status: LicenseStatus.valid,
      issueDate: '12/3/2020',
      expiryDate: '12/3/2026',
      hasUnpaidViolations: true,
    ),
    DrivingLicenseModel(
      licenseNumber: '12345678901235',
      licenseType: 'خاصة',
      governorate: 'الشرقية',
      licensingUnit: 'وحدة مرور العاشر',
      status: LicenseStatus.valid,
      issueDate: '12/3/2020',
      expiryDate: '12/3/2026',
      hasUnpaidViolations: false,
    ),
  ];
}
