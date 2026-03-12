import 'package:flutter/foundation.dart';

/// Holds the payment context information required by the generic payment flow.
///
/// This object should be instantiated by the originating feature (e.g. Renewal,
/// Replacement, Fines) and passed into the [PaymentMethodScreen].
@immutable
class PaymentIntent {
  /// The type of order being paid for (e.g. "بدل تالف").
  final String orderType;

  /// The total amount to be paid (e.g. 1500).
  final double amount;

  /// The currency of the payment (e.g. "جنية مصري").
  final String currency;

  const PaymentIntent({
    required this.orderType,
    required this.amount,
    required this.currency,
  });

  /// Helper to get the formatted amount string.
  String get formattedTotal => '${amount.toInt()} $currency';
}
