import 'package:freezed_annotation/freezed_annotation.dart';

part 'violation_model.freezed.dart';
part 'violation_model.g.dart';

@freezed
class ViolationModel with _$ViolationModel {
  const ViolationModel._();

  const factory ViolationModel({
    @Default(0) int violationId,
    @Default('') String violationNumber,
    @Default('') String violationType,
    @Default('') String legalReference,
    @Default('') String description,
    @Default('') String location,
    @Default('') String violationDateTime,
    @Default(0.0) double fineAmount,
    @Default(0.0) double paidAmount,
    @Default(0.0) double remainingAmount,
    @Default('') String status,
    @Default('') String statusAr,
    @Default(false) bool isPayable,
  }) = _ViolationModel;

  factory ViolationModel.fromJson(Map<String, dynamic> json) =>
      _$ViolationModelFromJson(json);

  /// Whether the violation is fully paid.
  bool get isPaid =>
      remainingAmount == 0 ||
      status.toLowerCase() == 'paid' ||
      statusAr == 'مدفوعة';

  /// A unique string ID to use as map key / selection key.
  String get id => violationId.toString();

  /// Payment date string shown in UI for paid violations.
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
}

@freezed
class ViolationsListModel with _$ViolationsListModel {
  const factory ViolationsListModel({
    @Default([]) List<ViolationModel> violations,
    @Default(0) int totalCount,
    @Default(0) int unpaidCount,
    @Default(0.0) double totalPayableAmount,
    @Default('') String message,
    @Default('') String messageAr,
  }) = _ViolationsListModel;

  factory ViolationsListModel.fromJson(Map<String, dynamic> json) =>
      _$ViolationsListModelFromJson(json);
}
