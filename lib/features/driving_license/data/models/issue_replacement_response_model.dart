import 'package:flutter/foundation.dart';

@immutable
class ReplacementFeesModel {
  final double baseFee;
  final double deliveryFee;
  final double totalAmount;

  const ReplacementFeesModel({
    required this.baseFee,
    required this.deliveryFee,
    required this.totalAmount,
  });

  factory ReplacementFeesModel.fromJson(Map<String, dynamic> json) {
    return ReplacementFeesModel(
      baseFee: (json['baseFee'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

@immutable
class IssueReplacementResponseModel {
  final String requestNumber;
  final String status;
  final ReplacementFeesModel? fees;
  final String citizenNationalId;
  final String serviceType;

  const IssueReplacementResponseModel({
    required this.requestNumber,
    required this.status,
    this.fees,
    required this.citizenNationalId,
    required this.serviceType,
  });

  factory IssueReplacementResponseModel.fromJson(Map<String, dynamic> json) {
    return IssueReplacementResponseModel(
      requestNumber: json['requestNumber']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      fees: json['fees'] != null
          ? ReplacementFeesModel.fromJson(json['fees'] as Map<String, dynamic>)
          : null,
      citizenNationalId: json['citizenNationalId']?.toString() ?? '',
      serviceType: json['serviceType']?.toString() ?? '',
    );
  }
}
