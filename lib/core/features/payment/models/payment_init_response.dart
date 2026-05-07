import 'package:flutter/foundation.dart';

@immutable
class PaymentInitResponse {
  final String paymentToken;
  final int paymentId;
  final String paymobOrderId;
  final String merchantOrderId;
  final String paymentUrl;

  const PaymentInitResponse({
    required this.paymentToken,
    required this.paymentId,
    required this.paymobOrderId,
    required this.merchantOrderId,
    required this.paymentUrl,
  });

  factory PaymentInitResponse.fromJson(Map<String, dynamic> json) {
    return PaymentInitResponse(
      paymentToken: json['paymentToken'] as String? ?? '',
      paymentId: json['paymentId'] as int? ?? 0,
      paymobOrderId: json['paymobOrderId'] as String? ?? '',
      merchantOrderId: json['merchantOrderId'] as String? ?? '',
      paymentUrl: json['paymentUrl'] as String? ?? '',
    );
  }
}
