import 'package:traffic/features/driving_license/domain/enums/license_status.dart';

/// Vehicle license model used for the violations inquiry sub-feature.
/// Populated from GET /VehicleLicense/my-licenses API response.
class VehicleLicenseViolationModel {
  final int id;
  final String vehicleLicenseNumber;
  final String plateNumber;
  final String vehicleType;
  final String brand;
  final String model;
  final LicenseStatus status;
  final String issueDate;
  final String expiryDate;
  final bool hasUnpaidViolations;

  const VehicleLicenseViolationModel({
    required this.id,
    required this.vehicleLicenseNumber,
    required this.plateNumber,
    required this.vehicleType,
    required this.brand,
    required this.model,
    required this.status,
    required this.issueDate,
    required this.expiryDate,
    this.hasUnpaidViolations = false,
  });

  // Compatibility getters used by existing widgets
  String get governorate => '';
  String get trafficUnit => '';

  factory VehicleLicenseViolationModel.fromJson(Map<String, dynamic> json) {
    final statusStr = (json['status'] as String? ?? '').toLowerCase();
    LicenseStatus mappedStatus = LicenseStatus.valid;
    if (statusStr.contains('expire') || statusStr.contains('منتهية')) {
      mappedStatus = LicenseStatus.expired;
    } else if (statusStr.contains('withdraw') || statusStr.contains('مسحوبة')) {
      mappedStatus = LicenseStatus.withdrawn;
    }

    return VehicleLicenseViolationModel(
      id: json['id'] as int? ?? 0,
      vehicleLicenseNumber:
          json['vehicleLicenseNumber'] as String? ?? '',
      plateNumber: json['plateNumber'] as String? ?? '',
      vehicleType: json['vehicleType'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      model: json['model'] as String? ?? '',
      status: mappedStatus,
      issueDate: json['issueDate'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      hasUnpaidViolations: json['hasUnpaidViolations'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'vehicleLicenseNumber': vehicleLicenseNumber,
        'plateNumber': plateNumber,
        'vehicleType': vehicleType,
        'brand': brand,
        'model': model,
        'status': status.name,
        'issueDate': issueDate,
        'expiryDate': expiryDate,
        'hasUnpaidViolations': hasUnpaidViolations,
      };
}
