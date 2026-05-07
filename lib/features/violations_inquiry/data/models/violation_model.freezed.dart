// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'violation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ViolationModel _$ViolationModelFromJson(Map<String, dynamic> json) {
  return _ViolationModel.fromJson(json);
}

/// @nodoc
mixin _$ViolationModel {
  int get violationId => throw _privateConstructorUsedError;
  String get violationNumber => throw _privateConstructorUsedError;
  String get violationType => throw _privateConstructorUsedError;
  String get legalReference => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get violationDateTime => throw _privateConstructorUsedError;
  double get fineAmount => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  double get remainingAmount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get statusAr => throw _privateConstructorUsedError;
  bool get isPayable => throw _privateConstructorUsedError;

  /// Serializes this ViolationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ViolationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ViolationModelCopyWith<ViolationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViolationModelCopyWith<$Res> {
  factory $ViolationModelCopyWith(
    ViolationModel value,
    $Res Function(ViolationModel) then,
  ) = _$ViolationModelCopyWithImpl<$Res, ViolationModel>;
  @useResult
  $Res call({
    int violationId,
    String violationNumber,
    String violationType,
    String legalReference,
    String description,
    String location,
    String violationDateTime,
    double fineAmount,
    double paidAmount,
    double remainingAmount,
    String status,
    String statusAr,
    bool isPayable,
  });
}

/// @nodoc
class _$ViolationModelCopyWithImpl<$Res, $Val extends ViolationModel>
    implements $ViolationModelCopyWith<$Res> {
  _$ViolationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViolationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? violationId = null,
    Object? violationNumber = null,
    Object? violationType = null,
    Object? legalReference = null,
    Object? description = null,
    Object? location = null,
    Object? violationDateTime = null,
    Object? fineAmount = null,
    Object? paidAmount = null,
    Object? remainingAmount = null,
    Object? status = null,
    Object? statusAr = null,
    Object? isPayable = null,
  }) {
    return _then(
      _value.copyWith(
            violationId: null == violationId
                ? _value.violationId
                : violationId // ignore: cast_nullable_to_non_nullable
                      as int,
            violationNumber: null == violationNumber
                ? _value.violationNumber
                : violationNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            violationType: null == violationType
                ? _value.violationType
                : violationType // ignore: cast_nullable_to_non_nullable
                      as String,
            legalReference: null == legalReference
                ? _value.legalReference
                : legalReference // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            violationDateTime: null == violationDateTime
                ? _value.violationDateTime
                : violationDateTime // ignore: cast_nullable_to_non_nullable
                      as String,
            fineAmount: null == fineAmount
                ? _value.fineAmount
                : fineAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            paidAmount: null == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            remainingAmount: null == remainingAmount
                ? _value.remainingAmount
                : remainingAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            statusAr: null == statusAr
                ? _value.statusAr
                : statusAr // ignore: cast_nullable_to_non_nullable
                      as String,
            isPayable: null == isPayable
                ? _value.isPayable
                : isPayable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ViolationModelImplCopyWith<$Res>
    implements $ViolationModelCopyWith<$Res> {
  factory _$$ViolationModelImplCopyWith(
    _$ViolationModelImpl value,
    $Res Function(_$ViolationModelImpl) then,
  ) = __$$ViolationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int violationId,
    String violationNumber,
    String violationType,
    String legalReference,
    String description,
    String location,
    String violationDateTime,
    double fineAmount,
    double paidAmount,
    double remainingAmount,
    String status,
    String statusAr,
    bool isPayable,
  });
}

/// @nodoc
class __$$ViolationModelImplCopyWithImpl<$Res>
    extends _$ViolationModelCopyWithImpl<$Res, _$ViolationModelImpl>
    implements _$$ViolationModelImplCopyWith<$Res> {
  __$$ViolationModelImplCopyWithImpl(
    _$ViolationModelImpl _value,
    $Res Function(_$ViolationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ViolationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? violationId = null,
    Object? violationNumber = null,
    Object? violationType = null,
    Object? legalReference = null,
    Object? description = null,
    Object? location = null,
    Object? violationDateTime = null,
    Object? fineAmount = null,
    Object? paidAmount = null,
    Object? remainingAmount = null,
    Object? status = null,
    Object? statusAr = null,
    Object? isPayable = null,
  }) {
    return _then(
      _$ViolationModelImpl(
        violationId: null == violationId
            ? _value.violationId
            : violationId // ignore: cast_nullable_to_non_nullable
                  as int,
        violationNumber: null == violationNumber
            ? _value.violationNumber
            : violationNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        violationType: null == violationType
            ? _value.violationType
            : violationType // ignore: cast_nullable_to_non_nullable
                  as String,
        legalReference: null == legalReference
            ? _value.legalReference
            : legalReference // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        violationDateTime: null == violationDateTime
            ? _value.violationDateTime
            : violationDateTime // ignore: cast_nullable_to_non_nullable
                  as String,
        fineAmount: null == fineAmount
            ? _value.fineAmount
            : fineAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        paidAmount: null == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        remainingAmount: null == remainingAmount
            ? _value.remainingAmount
            : remainingAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        statusAr: null == statusAr
            ? _value.statusAr
            : statusAr // ignore: cast_nullable_to_non_nullable
                  as String,
        isPayable: null == isPayable
            ? _value.isPayable
            : isPayable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ViolationModelImpl extends _ViolationModel {
  const _$ViolationModelImpl({
    this.violationId = 0,
    this.violationNumber = '',
    this.violationType = '',
    this.legalReference = '',
    this.description = '',
    this.location = '',
    this.violationDateTime = '',
    this.fineAmount = 0.0,
    this.paidAmount = 0.0,
    this.remainingAmount = 0.0,
    this.status = '',
    this.statusAr = '',
    this.isPayable = false,
  }) : super._();

  factory _$ViolationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViolationModelImplFromJson(json);

  @override
  @JsonKey()
  final int violationId;
  @override
  @JsonKey()
  final String violationNumber;
  @override
  @JsonKey()
  final String violationType;
  @override
  @JsonKey()
  final String legalReference;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String violationDateTime;
  @override
  @JsonKey()
  final double fineAmount;
  @override
  @JsonKey()
  final double paidAmount;
  @override
  @JsonKey()
  final double remainingAmount;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String statusAr;
  @override
  @JsonKey()
  final bool isPayable;

  @override
  String toString() {
    return 'ViolationModel(violationId: $violationId, violationNumber: $violationNumber, violationType: $violationType, legalReference: $legalReference, description: $description, location: $location, violationDateTime: $violationDateTime, fineAmount: $fineAmount, paidAmount: $paidAmount, remainingAmount: $remainingAmount, status: $status, statusAr: $statusAr, isPayable: $isPayable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViolationModelImpl &&
            (identical(other.violationId, violationId) ||
                other.violationId == violationId) &&
            (identical(other.violationNumber, violationNumber) ||
                other.violationNumber == violationNumber) &&
            (identical(other.violationType, violationType) ||
                other.violationType == violationType) &&
            (identical(other.legalReference, legalReference) ||
                other.legalReference == legalReference) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.violationDateTime, violationDateTime) ||
                other.violationDateTime == violationDateTime) &&
            (identical(other.fineAmount, fineAmount) ||
                other.fineAmount == fineAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.remainingAmount, remainingAmount) ||
                other.remainingAmount == remainingAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusAr, statusAr) ||
                other.statusAr == statusAr) &&
            (identical(other.isPayable, isPayable) ||
                other.isPayable == isPayable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    violationId,
    violationNumber,
    violationType,
    legalReference,
    description,
    location,
    violationDateTime,
    fineAmount,
    paidAmount,
    remainingAmount,
    status,
    statusAr,
    isPayable,
  );

  /// Create a copy of ViolationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViolationModelImplCopyWith<_$ViolationModelImpl> get copyWith =>
      __$$ViolationModelImplCopyWithImpl<_$ViolationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ViolationModelImplToJson(this);
  }
}

abstract class _ViolationModel extends ViolationModel {
  const factory _ViolationModel({
    final int violationId,
    final String violationNumber,
    final String violationType,
    final String legalReference,
    final String description,
    final String location,
    final String violationDateTime,
    final double fineAmount,
    final double paidAmount,
    final double remainingAmount,
    final String status,
    final String statusAr,
    final bool isPayable,
  }) = _$ViolationModelImpl;
  const _ViolationModel._() : super._();

  factory _ViolationModel.fromJson(Map<String, dynamic> json) =
      _$ViolationModelImpl.fromJson;

  @override
  int get violationId;
  @override
  String get violationNumber;
  @override
  String get violationType;
  @override
  String get legalReference;
  @override
  String get description;
  @override
  String get location;
  @override
  String get violationDateTime;
  @override
  double get fineAmount;
  @override
  double get paidAmount;
  @override
  double get remainingAmount;
  @override
  String get status;
  @override
  String get statusAr;
  @override
  bool get isPayable;

  /// Create a copy of ViolationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViolationModelImplCopyWith<_$ViolationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ViolationsListModel _$ViolationsListModelFromJson(Map<String, dynamic> json) {
  return _ViolationsListModel.fromJson(json);
}

/// @nodoc
mixin _$ViolationsListModel {
  List<ViolationModel> get violations => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get unpaidCount => throw _privateConstructorUsedError;
  double get totalPayableAmount => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get messageAr => throw _privateConstructorUsedError;

  /// Serializes this ViolationsListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ViolationsListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ViolationsListModelCopyWith<ViolationsListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViolationsListModelCopyWith<$Res> {
  factory $ViolationsListModelCopyWith(
    ViolationsListModel value,
    $Res Function(ViolationsListModel) then,
  ) = _$ViolationsListModelCopyWithImpl<$Res, ViolationsListModel>;
  @useResult
  $Res call({
    List<ViolationModel> violations,
    int totalCount,
    int unpaidCount,
    double totalPayableAmount,
    String message,
    String messageAr,
  });
}

/// @nodoc
class _$ViolationsListModelCopyWithImpl<$Res, $Val extends ViolationsListModel>
    implements $ViolationsListModelCopyWith<$Res> {
  _$ViolationsListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViolationsListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? violations = null,
    Object? totalCount = null,
    Object? unpaidCount = null,
    Object? totalPayableAmount = null,
    Object? message = null,
    Object? messageAr = null,
  }) {
    return _then(
      _value.copyWith(
            violations: null == violations
                ? _value.violations
                : violations // ignore: cast_nullable_to_non_nullable
                      as List<ViolationModel>,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            unpaidCount: null == unpaidCount
                ? _value.unpaidCount
                : unpaidCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPayableAmount: null == totalPayableAmount
                ? _value.totalPayableAmount
                : totalPayableAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            messageAr: null == messageAr
                ? _value.messageAr
                : messageAr // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ViolationsListModelImplCopyWith<$Res>
    implements $ViolationsListModelCopyWith<$Res> {
  factory _$$ViolationsListModelImplCopyWith(
    _$ViolationsListModelImpl value,
    $Res Function(_$ViolationsListModelImpl) then,
  ) = __$$ViolationsListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ViolationModel> violations,
    int totalCount,
    int unpaidCount,
    double totalPayableAmount,
    String message,
    String messageAr,
  });
}

/// @nodoc
class __$$ViolationsListModelImplCopyWithImpl<$Res>
    extends _$ViolationsListModelCopyWithImpl<$Res, _$ViolationsListModelImpl>
    implements _$$ViolationsListModelImplCopyWith<$Res> {
  __$$ViolationsListModelImplCopyWithImpl(
    _$ViolationsListModelImpl _value,
    $Res Function(_$ViolationsListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ViolationsListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? violations = null,
    Object? totalCount = null,
    Object? unpaidCount = null,
    Object? totalPayableAmount = null,
    Object? message = null,
    Object? messageAr = null,
  }) {
    return _then(
      _$ViolationsListModelImpl(
        violations: null == violations
            ? _value._violations
            : violations // ignore: cast_nullable_to_non_nullable
                  as List<ViolationModel>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        unpaidCount: null == unpaidCount
            ? _value.unpaidCount
            : unpaidCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPayableAmount: null == totalPayableAmount
            ? _value.totalPayableAmount
            : totalPayableAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        messageAr: null == messageAr
            ? _value.messageAr
            : messageAr // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ViolationsListModelImpl implements _ViolationsListModel {
  const _$ViolationsListModelImpl({
    final List<ViolationModel> violations = const [],
    this.totalCount = 0,
    this.unpaidCount = 0,
    this.totalPayableAmount = 0.0,
    this.message = '',
    this.messageAr = '',
  }) : _violations = violations;

  factory _$ViolationsListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViolationsListModelImplFromJson(json);

  final List<ViolationModel> _violations;
  @override
  @JsonKey()
  List<ViolationModel> get violations {
    if (_violations is EqualUnmodifiableListView) return _violations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_violations);
  }

  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int unpaidCount;
  @override
  @JsonKey()
  final double totalPayableAmount;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String messageAr;

  @override
  String toString() {
    return 'ViolationsListModel(violations: $violations, totalCount: $totalCount, unpaidCount: $unpaidCount, totalPayableAmount: $totalPayableAmount, message: $message, messageAr: $messageAr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViolationsListModelImpl &&
            const DeepCollectionEquality().equals(
              other._violations,
              _violations,
            ) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.unpaidCount, unpaidCount) ||
                other.unpaidCount == unpaidCount) &&
            (identical(other.totalPayableAmount, totalPayableAmount) ||
                other.totalPayableAmount == totalPayableAmount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageAr, messageAr) ||
                other.messageAr == messageAr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_violations),
    totalCount,
    unpaidCount,
    totalPayableAmount,
    message,
    messageAr,
  );

  /// Create a copy of ViolationsListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViolationsListModelImplCopyWith<_$ViolationsListModelImpl> get copyWith =>
      __$$ViolationsListModelImplCopyWithImpl<_$ViolationsListModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ViolationsListModelImplToJson(this);
  }
}

abstract class _ViolationsListModel implements ViolationsListModel {
  const factory _ViolationsListModel({
    final List<ViolationModel> violations,
    final int totalCount,
    final int unpaidCount,
    final double totalPayableAmount,
    final String message,
    final String messageAr,
  }) = _$ViolationsListModelImpl;

  factory _ViolationsListModel.fromJson(Map<String, dynamic> json) =
      _$ViolationsListModelImpl.fromJson;

  @override
  List<ViolationModel> get violations;
  @override
  int get totalCount;
  @override
  int get unpaidCount;
  @override
  double get totalPayableAmount;
  @override
  String get message;
  @override
  String get messageAr;

  /// Create a copy of ViolationsListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViolationsListModelImplCopyWith<_$ViolationsListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
