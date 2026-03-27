
enum VehicleLicenseStatus {
  valid,
  expired,
  suspended,
  withdrawn,
}

class VehicleLicenseModel {
  final String plateNumber;
  final String vehicleType;
  final String expiryDate;
  final VehicleLicenseStatus status;
  final bool hasUnpaidViolations;

  const VehicleLicenseModel({
    required this.plateNumber,
    required this.vehicleType,
    required this.expiryDate,
    required this.status,
    this.hasUnpaidViolations = false,
  });

  static List<VehicleLicenseModel> get dummyVehicles => [
        const VehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: VehicleLicenseStatus.valid,
        ),
        const VehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: VehicleLicenseStatus.expired,
        ),
        const VehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: VehicleLicenseStatus.valid,
          hasUnpaidViolations: true,
        ),
        const VehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: VehicleLicenseStatus.suspended,
        ),
        const VehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: VehicleLicenseStatus.withdrawn,
        ),
      ];
}
