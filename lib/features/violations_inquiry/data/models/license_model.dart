class DrivingLicenseModel {
  final String licenseNumber;
  final String type;
  final String governorate;
  final String licensingUnit;
  final String status;
  final String issueDate;
  final String expiryDate;

  const DrivingLicenseModel({
    required this.licenseNumber,
    required this.type,
    required this.governorate,
    required this.licensingUnit,
    required this.status,
    required this.issueDate,
    required this.expiryDate,
  });

  /// Dummy data for UI development
  static List<DrivingLicenseModel> get dummyLicenses => const [
    DrivingLicenseModel(
      licenseNumber: '12345678901234',
      type: 'خاصة',
      governorate: 'الشرقية',
      licensingUnit: 'وحدة مرور العاشر',
      status: 'سارية',
      issueDate: '12/3/2020',
      expiryDate: '12/3/2026',
    ),
    DrivingLicenseModel(
      licenseNumber: '12345678901234',
      type: 'خاصة',
      governorate: 'الشرقية',
      licensingUnit: 'وحدة مرور العاشر',
      status: 'سارية',
      issueDate: '12/3/2020',
      expiryDate: '12/3/2026',
    ),
  ];
}
