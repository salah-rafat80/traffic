enum OrderStatus {
  pending,
  completed,
  needsData,
  awaitingService,
  passed,
  failed,
}

class OrderFees {
  final double baseFee;
  final double deliveryFee;
  final double totalAmount;

  const OrderFees({
    required this.baseFee,
    required this.deliveryFee,
    required this.totalAmount,
  });

  factory OrderFees.fromJson(Map<String, dynamic> json) {
    return OrderFees(
      baseFee: (json['baseFee'] as num? ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] as num? ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] as num? ?? 0).toDouble(),
    );
  }
}

class OrderDelivery {
  final String? method;
  final String? address;

  const OrderDelivery({this.method, this.address});

  factory OrderDelivery.fromJson(Map<String, dynamic> json) {
    return OrderDelivery(
      method: json['method']?.toString(),
      address: json['address']?.toString(),
    );
  }
}

class OrderPayment {
  final String paymentStatus;
  final String? transactionId;
  final double? amount;
  final String? timestamp;

  const OrderPayment({
    required this.paymentStatus,
    this.transactionId,
    this.amount,
    this.timestamp,
  });

  factory OrderPayment.fromJson(Map<String, dynamic> json) {
    return OrderPayment(
      paymentStatus: json['status']?.toString() ?? '',
      transactionId: json['transactionId']?.toString(),
      amount: json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : null,
      timestamp: json['timestamp']?.toString(),
    );
  }
}

class OrderModel {
  /// Unique request number, e.g. "DR-800"
  final String id;

  /// Service type label, e.g. "تجديد رخصة قيادة"
  final String title;

  /// ISO 8601 submission timestamp
  final String date;

  final OrderStatus status;

  // ── Extra fields (available from list, needed for details pane) ──
  final String? citizenNationalId;
  final String? lastUpdatedAt;
  final int? referenceId;
  final OrderFees? fees;
  final OrderDelivery? delivery;
  final OrderPayment? payment;

  const OrderModel({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    this.citizenNationalId,
    this.lastUpdatedAt,
    this.referenceId,
    this.fees,
    this.delivery,
    this.payment,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['requestNumber']?.toString() ?? '',
      title: json['serviceType']?.toString() ?? 'طلب خدمة',
      date: json['submittedAt']?.toString() ?? '',
      status: _parseStatus(json['status']?.toString() ?? ''),
      citizenNationalId: json['citizenNationalId']?.toString(),
      lastUpdatedAt: json['lastUpdatedAt']?.toString(),
      referenceId: json['referenceId'] as int?,
      fees: json['fees'] is Map<String, dynamic>
          ? OrderFees.fromJson(json['fees'] as Map<String, dynamic>)
          : null,
      delivery: json['delivery'] is Map<String, dynamic>
          ? OrderDelivery.fromJson(json['delivery'] as Map<String, dynamic>)
          : null,
      payment: json['payment'] is Map<String, dynamic>
          ? OrderPayment.fromJson(json['payment'] as Map<String, dynamic>)
          : null,
    );
  }

  static OrderStatus _parseStatus(String status) {
    // Explicit Arabic values returned by the API
    if (status.contains('قيد التنفيذ') || status.contains('قيد الانتظار')) {
      return OrderStatus.pending;
    }
    if (status.contains('مكتمل') || status.contains('complete')) {
      return OrderStatus.completed;
    }
    if (status.contains('مرفوض') ||
        status.contains('لم يتم') ||
        status.toLowerCase().contains('fail')) {
      return OrderStatus.failed;
    }
    if (status.contains('تم اجتياز') || status.toLowerCase().contains('pass')) {
      return OrderStatus.passed;
    }
    if (status.contains('استكمال') ||
        status.contains('مطلوب') ||
        status.toLowerCase().contains('data')) {
      return OrderStatus.needsData;
    }
    if (status.contains('بانتظار الموعد') || status.toLowerCase().contains('wait')) {
      return OrderStatus.awaitingService;
    }
    return OrderStatus.pending;
  }
}
