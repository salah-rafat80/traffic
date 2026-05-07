// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViolationModelImpl _$$ViolationModelImplFromJson(Map<String, dynamic> json) =>
    _$ViolationModelImpl(
      violationId: (json['violationId'] as num?)?.toInt() ?? 0,
      violationNumber: json['violationNumber'] as String? ?? '',
      violationType: json['violationType'] as String? ?? '',
      legalReference: json['legalReference'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      violationDateTime: json['violationDateTime'] as String? ?? '',
      fineAmount: (json['fineAmount'] as num?)?.toDouble() ?? 0.0,
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0.0,
      remainingAmount: (json['remainingAmount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      statusAr: json['statusAr'] as String? ?? '',
      isPayable: json['isPayable'] as bool? ?? false,
    );

Map<String, dynamic> _$$ViolationModelImplToJson(
  _$ViolationModelImpl instance,
) => <String, dynamic>{
  'violationId': instance.violationId,
  'violationNumber': instance.violationNumber,
  'violationType': instance.violationType,
  'legalReference': instance.legalReference,
  'description': instance.description,
  'location': instance.location,
  'violationDateTime': instance.violationDateTime,
  'fineAmount': instance.fineAmount,
  'paidAmount': instance.paidAmount,
  'remainingAmount': instance.remainingAmount,
  'status': instance.status,
  'statusAr': instance.statusAr,
  'isPayable': instance.isPayable,
};

_$ViolationsListModelImpl _$$ViolationsListModelImplFromJson(
  Map<String, dynamic> json,
) => _$ViolationsListModelImpl(
  violations:
      (json['violations'] as List<dynamic>?)
          ?.map((e) => ViolationModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  unpaidCount: (json['unpaidCount'] as num?)?.toInt() ?? 0,
  totalPayableAmount: (json['totalPayableAmount'] as num?)?.toDouble() ?? 0.0,
  message: json['message'] as String? ?? '',
  messageAr: json['messageAr'] as String? ?? '',
);

Map<String, dynamic> _$$ViolationsListModelImplToJson(
  _$ViolationsListModelImpl instance,
) => <String, dynamic>{
  'violations': instance.violations,
  'totalCount': instance.totalCount,
  'unpaidCount': instance.unpaidCount,
  'totalPayableAmount': instance.totalPayableAmount,
  'message': instance.message,
  'messageAr': instance.messageAr,
};
