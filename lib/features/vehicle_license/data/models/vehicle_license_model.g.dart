// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_license_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleLicenseModelImpl _$$VehicleLicenseModelImplFromJson(
  Map<String, dynamic> json,
) => _$VehicleLicenseModelImpl(
  id: (json['id'] as num?)?.toInt() ?? 0,
  vehicleLicenseNumber: json['vehicleLicenseNumber'] as String? ?? '',
  plateNumber: json['plateNumber'] as String?,
  category: json['category'] as String? ?? '',
  brand: json['brand'] as String? ?? '',
  model: json['model'] as String? ?? '',
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

Map<String, dynamic> _$$VehicleLicenseModelImplToJson(
  _$VehicleLicenseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'vehicleLicenseNumber': instance.vehicleLicenseNumber,
  'plateNumber': instance.plateNumber,
  'category': instance.category,
  'brand': instance.brand,
  'model': instance.model,
  'governorate': instance.governorate,
  'licensingUnit': instance.licensingUnit,
  'issueDate': instance.issueDate,
  'expiryDate': instance.expiryDate,
  'status': _statusToJson(instance.status),
  'citizenName': instance.citizenName,
  'hasUnpaidViolations': instance.hasUnpaidViolations,
  'delivery': instance.delivery,
};
