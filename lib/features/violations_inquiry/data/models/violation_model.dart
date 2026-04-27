/// Model for a single traffic violation returned by:
/// GET /TrafficViolations/license/{licenseNumber}/details?licenseType=Driving
class ViolationModel {
  final int violationId;
  final String violationNumber;
  final String violationType;
  final String legalReference;
  final String description;
  final String location;
  final String violationDateTime;
  final double fineAmount;
  final double paidAmount;
  final double remainingAmount;
  final String status;
  final String statusAr;
  final bool isPayable;

  const ViolationModel({
    required this.violationId,
    required this.violationNumber,
    required this.violationType,
    required this.legalReference,
    required this.description,
    required this.location,
    required this.violationDateTime,
    required this.fineAmount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.status,
    required this.statusAr,
    required this.isPayable,
  });

  /// Whether the violation is fully paid.
  bool get isPaid => status.toLowerCase() == 'paid';

  /// A unique string ID to use as map key / selection key.
  String get id => violationId.toString();

  /// Payment date string shown in UI for paid violations.
  /// Derived from [violationDateTime] when [isPaid] is true.
  String? get paymentDate => isPaid ? '$time, $date' : null;

  /// Formatted date extracted from violationDateTime ISO string.
  String get date {
    try {
      final dt = DateTime.parse(violationDateTime);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return violationDateTime;
    }
  }

  /// Formatted time extracted from violationDateTime ISO string.
  String get time {
    try {
      final dt = DateTime.parse(violationDateTime);
      final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final minute = dt.minute.toString().padLeft(2, '0');
      final amPm = dt.hour < 12 ? 'AM' : 'PM';
      return '$hour:$minute $amPm';
    } catch (_) {
      return '';
    }
  }

  /// Legacy getter aliases (used by existing UI widgets).
  String get title => violationType;
  String get articleNumber => legalReference;
  String get articleText => description;
  double get amount => remainingAmount > 0 ? remainingAmount : fineAmount;

  factory ViolationModel.fromJson(Map<String, dynamic> json) {
    return ViolationModel(
      violationId: json['violationId'] as int? ?? 0,
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
  }
}

/// Wrapper model for the full API response details object.
class ViolationsListModel {
  final List<ViolationModel> violations;
  final int totalCount;
  final int unpaidCount;
  final double totalPayableAmount;
  final String message;
  final String messageAr;

  const ViolationsListModel({
    required this.violations,
    required this.totalCount,
    required this.unpaidCount,
    required this.totalPayableAmount,
    required this.message,
    required this.messageAr,
  });

  factory ViolationsListModel.fromJson(Map<String, dynamic> json) {
    final rawList = json['violations'];
    final violations = rawList is List
        ? rawList
            .map((e) => ViolationModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : <ViolationModel>[];

    return ViolationsListModel(
      violations: violations,
      totalCount: json['totalCount'] as int? ?? 0,
      unpaidCount: json['unpaidCount'] as int? ?? 0,
      totalPayableAmount:
          (json['totalPayableAmount'] as num?)?.toDouble() ?? 0.0,
      message: json['message'] as String? ?? '',
      messageAr: json['messageAr'] as String? ?? '',
    );
  }
}
