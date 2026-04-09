import 'package:traffic/features/driving_license/domain/enums/license_status.dart';

class DrivingLicenseModel {
  final int id;
  final String drivingLicenseNumber;
  final String category;
  final String governorate;
  final String licensingUnit;
  final String issueDate;
  final String expiryDate;
  final LicenseStatus status;
  final String citizenName;
  final bool hasUnpaidViolations;
  final DeliveryModel? delivery;

  const DrivingLicenseModel({
    required this.id,
    required this.drivingLicenseNumber,
    required this.category,
    required this.governorate,
    required this.licensingUnit,
    required this.issueDate,
    required this.expiryDate,
    required this.status,
    required this.citizenName,
    this.hasUnpaidViolations = false,
    this.delivery,
  });

  // Compatibility getters for legacy code
  String get licenseNumber => drivingLicenseNumber;
  String get licenseType => category;

  factory DrivingLicenseModel.fromJson(Map<String, dynamic> json) {
    // Map status string to LicenseStatus enum
    final statusStr = (json['status'] as String? ?? '').toLowerCase();
    LicenseStatus mappedStatus = LicenseStatus.valid;
    if (statusStr.contains('expire') || statusStr.contains('منتهية')) {
      mappedStatus = LicenseStatus.expired;
    } else if (statusStr.contains('withdraw') || statusStr.contains('مسحوبة')) {
      mappedStatus = LicenseStatus.withdrawn;
    }

    return DrivingLicenseModel(
      id: json['id'] as int? ?? 0,
      drivingLicenseNumber: json['drivingLicenseNumber'] as String? ?? json['licenseNumber'] as String? ?? '',
      category: json['category'] as String? ?? json['licenseType'] as String? ?? '',
      governorate: json['governorate'] as String? ?? '',
      licensingUnit: json['licensingUnit'] as String? ?? '',
      issueDate: json['issueDate'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      status: mappedStatus,
      citizenName: json['citizenName'] as String? ?? '',
      hasUnpaidViolations: json['hasUnpaidViolations'] as bool? ?? false,
      delivery: json['delivery'] != null
          ? DeliveryModel.fromJson(json['delivery'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drivingLicenseNumber': drivingLicenseNumber,
      'category': category,
      'governorate': governorate,
      'licensingUnit': licensingUnit,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'status': status.name,
      'citizenName': citizenName,
      'hasUnpaidViolations': hasUnpaidViolations,
      'delivery': delivery?.toJson(),
    };
  }

  /// Dummy data for UI development and fallback
  static List<DrivingLicenseModel> get dummyLicenses => [
        const DrivingLicenseModel(
          id: 1,
          drivingLicenseNumber: '11223344556677',
          category: 'خاصة',
          governorate: 'الجيزة',
          licensingUnit: 'وحدة مرور الدقي',
          status: LicenseStatus.withdrawn,
          issueDate: '10/6/2015',
          expiryDate: '10/6/2021',
          citizenName: 'محمد أحمد علي',
        ),
        const DrivingLicenseModel(
          id: 2,
          drivingLicenseNumber: '12345678901234',
          category: 'خاصة',
          governorate: 'الشرقية',
          licensingUnit: 'وحدة مرور العاشر',
          status: LicenseStatus.valid,
          issueDate: '12/3/2020',
          expiryDate: '12/3/2026',
          citizenName: 'أحمد محمود حسن',
          hasUnpaidViolations: true,
        ),
      ];
}


class DeliveryModel {
  final String method;
  final AddressModel? address;

  const DeliveryModel({
    required this.method,
    this.address,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      method: json['method'] as String? ?? '',
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'address': address?.toJson(),
    };
  }
}

class AddressModel {
  final String governorate;
  final String city;
  final String details;

  const AddressModel({
    required this.governorate,
    required this.city,
    required this.details,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      governorate: json['governorate'] as String? ?? '',
      city: json['city'] as String? ?? '',
      details: json['details'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governorate': governorate,
      'city': city,
      'details': details,
    };
  }
}
