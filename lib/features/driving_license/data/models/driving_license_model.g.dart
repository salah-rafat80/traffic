// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driving_license_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DrivingLicenseModelImpl _$$DrivingLicenseModelImplFromJson(
  Map<String, dynamic> json,
) => _$DrivingLicenseModelImpl(
  id: (json['id'] as num?)?.toInt() ?? 0,
  drivingLicenseNumber: json['licenseNumber'] as String? ?? '',
  category: json['category'] as String? ?? '',
  governorate: json['governorate'] as String? ?? '',
  licensingUnit: json['licensingUnit'] as String? ?? '',
  issueDate: json['issueDate'] as String? ?? '',
  expiryDate: json['expiryDate'] as String? ?? '',
  status: json['status'] == null
      ? LicenseStatus.valid
      : _statusFromJson(json['status']),
  citizenName: json['citizenName'] as String? ?? '',
  hasUnpaidViolations: json['hasUnpaidViolations'] as bool? ?? false,
  delivery: json['delivery'] == null
      ? null
      : DeliveryModel.fromJson(json['delivery'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DrivingLicenseModelImplToJson(
  _$DrivingLicenseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'licenseNumber': instance.drivingLicenseNumber,
  'category': instance.category,
  'governorate': instance.governorate,
  'licensingUnit': instance.licensingUnit,
  'issueDate': instance.issueDate,
  'expiryDate': instance.expiryDate,
  'status': _statusToJson(instance.status),
  'citizenName': instance.citizenName,
  'hasUnpaidViolations': instance.hasUnpaidViolations,
  'delivery': instance.delivery,
};
