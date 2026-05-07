import 'package:flutter/foundation.dart';

/// Fees breakdown returned by `POST /DrivingLicense/finalize/{requestNumber}`.
@immutable
class DrivingLicenseFinalizeFeesModel {
  final double baseFee;
  final double deliveryFee;
  final double totalAmount;

  const DrivingLicenseFinalizeFeesModel({
    required this.baseFee,
    required this.deliveryFee,
    required this.totalAmount,
  });

  factory DrivingLicenseFinalizeFeesModel.fromJson(
      Map<String, Object?> json) {
    return DrivingLicenseFinalizeFeesModel(
      baseFee: (json['baseFee'] as num? ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] as num? ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] as num? ?? 0).toDouble(),
    );
  }
}

/// Full response model for `POST /DrivingLicense/finalize/{requestNumber}`.
///
/// The backend returns this inside `{ "isSuccess": true, "details": {...} }`.
@immutable
class DrivingLicenseFinalizeResponseModel {
  final String requestNumber;
  final String citizenNationalId;
  final String serviceType;
  final String status;
  final String? submittedAt;
  final DrivingLicenseFinalizeFeesModel? fees;

  const DrivingLicenseFinalizeResponseModel({
    required this.requestNumber,
    required this.citizenNationalId,
    required this.serviceType,
    required this.status,
    this.submittedAt,
    this.fees,
  });

  factory DrivingLicenseFinalizeResponseModel.fromJson(
      Map<String, Object?> json) {
    DrivingLicenseFinalizeFeesModel? fees;

    // Dio may return Map<String, dynamic> or Map<String, Object?> — handle both.
    final Object? rawFees = json['fees'];
    if (rawFees is Map) {
      fees = DrivingLicenseFinalizeFeesModel.fromJson(
        rawFees.map((k, v) => MapEntry(k.toString(), v as Object?)),
      );
    }

    return DrivingLicenseFinalizeResponseModel(
      requestNumber: (json['requestNumber'] ?? '').toString(),
      citizenNationalId: (json['citizenNationalId'] ?? '').toString(),
      serviceType: (json['serviceType'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      submittedAt: json['submittedAt']?.toString(),
      fees: fees,
    );
  }
}
