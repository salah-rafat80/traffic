// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      governorate: json['governorate'] as String? ?? '',
      city: json['city'] as String? ?? '',
      details: json['details'] as String? ?? '',
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'governorate': instance.governorate,
      'city': instance.city,
      'details': instance.details,
    };

_$DeliveryModelImpl _$$DeliveryModelImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryModelImpl(
      method: json['method'] as String? ?? '',
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DeliveryModelImplToJson(_$DeliveryModelImpl instance) =>
    <String, dynamic>{'method': instance.method, 'address': instance.address};
