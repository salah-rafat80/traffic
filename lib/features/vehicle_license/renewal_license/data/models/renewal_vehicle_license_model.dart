
enum RenewalLicenseStatus {
  valid,
  expired,
  suspended,
  withdrawn,
}

class RenewalVehicleLicenseModel {
  final String plateNumber;
  final String vehicleType;
  final String expiryDate;
  final RenewalLicenseStatus status;
  final bool hasUnpaidViolations;
  final bool needsTechnicalInspection;
  final bool needsInsuranceRenewal;

  const RenewalVehicleLicenseModel({
    required this.plateNumber,
    required this.vehicleType,
    required this.expiryDate,
    required this.status,
    this.hasUnpaidViolations = false,
    this.needsTechnicalInspection = false,
    this.needsInsuranceRenewal = false,
  });

  /// Whether the license can be renewed electronically.
  bool get canRenew =>
      !hasUnpaidViolations &&
      status != RenewalLicenseStatus.suspended &&
      status != RenewalLicenseStatus.withdrawn;

  static List<RenewalVehicleLicenseModel> get dummyVehicles => [
        // 1 – Valid + already renewed (can't renew again)
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.valid,
        ),
        // 2 – Expired
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.expired,
        ),
        // 3 – Valid + unpaid violations
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.valid,
          hasUnpaidViolations: true,
        ),
        // 4 – Suspended
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.suspended,
        ),
        // 5 – Withdrawn
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.withdrawn,
        ),
        // 6 – Needs technical inspection
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.valid,
          needsTechnicalInspection: true,
        ),
        // 7 – Needs insurance renewal
        const RenewalVehicleLicenseModel(
          plateNumber: 'س ج ر ٤٢١٣',
          vehicleType: 'ملاكي – هيونداي إلنترا',
          expiryDate: '12/3/2026',
          status: RenewalLicenseStatus.valid,
          needsInsuranceRenewal: true,
        ),
      ];
}
