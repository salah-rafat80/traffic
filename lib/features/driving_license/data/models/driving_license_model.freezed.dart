// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driving_license_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DrivingLicenseModel _$DrivingLicenseModelFromJson(Map<String, dynamic> json) {
  return _DrivingLicenseModel.fromJson(json);
}

/// @nodoc
mixin _$DrivingLicenseModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'licenseNumber')
  String get drivingLicenseNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String get category => throw _privateConstructorUsedError;
  String get governorate => throw _privateConstructorUsedError;
  String get licensingUnit => throw _privateConstructorUsedError;
  String get issueDate => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  LicenseStatus get status => throw _privateConstructorUsedError;
  String get citizenName => throw _privateConstructorUsedError;
  bool get hasUnpaidViolations => throw _privateConstructorUsedError;
  DeliveryModel? get delivery => throw _privateConstructorUsedError;

  /// Serializes this DrivingLicenseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrivingLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrivingLicenseModelCopyWith<DrivingLicenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrivingLicenseModelCopyWith<$Res> {
  factory $DrivingLicenseModelCopyWith(
    DrivingLicenseModel value,
    $Res Function(DrivingLicenseModel) then,
  ) = _$DrivingLicenseModelCopyWithImpl<$Res, DrivingLicenseModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'licenseNumber') String drivingLicenseNumber,
    @JsonKey(name: 'category') String category,
    String governorate,
    String licensingUnit,
    String issueDate,
    String expiryDate,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    LicenseStatus status,
    String citizenName,
    bool hasUnpaidViolations,
    DeliveryModel? delivery,
  });

  $DeliveryModelCopyWith<$Res>? get delivery;
}

/// @nodoc
class _$DrivingLicenseModelCopyWithImpl<$Res, $Val extends DrivingLicenseModel>
    implements $DrivingLicenseModelCopyWith<$Res> {
  _$DrivingLicenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrivingLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? drivingLicenseNumber = null,
    Object? category = null,
    Object? governorate = null,
    Object? licensingUnit = null,
    Object? issueDate = null,
    Object? expiryDate = null,
    Object? status = null,
    Object? citizenName = null,
    Object? hasUnpaidViolations = null,
    Object? delivery = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            drivingLicenseNumber: null == drivingLicenseNumber
                ? _value.drivingLicenseNumber
                : drivingLicenseNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            governorate: null == governorate
                ? _value.governorate
                : governorate // ignore: cast_nullable_to_non_nullable
                      as String,
            licensingUnit: null == licensingUnit
                ? _value.licensingUnit
                : licensingUnit // ignore: cast_nullable_to_non_nullable
                      as String,
            issueDate: null == issueDate
                ? _value.issueDate
                : issueDate // ignore: cast_nullable_to_non_nullable
                      as String,
            expiryDate: null == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as LicenseStatus,
            citizenName: null == citizenName
                ? _value.citizenName
                : citizenName // ignore: cast_nullable_to_non_nullable
                      as String,
            hasUnpaidViolations: null == hasUnpaidViolations
                ? _value.hasUnpaidViolations
                : hasUnpaidViolations // ignore: cast_nullable_to_non_nullable
                      as bool,
            delivery: freezed == delivery
                ? _value.delivery
                : delivery // ignore: cast_nullable_to_non_nullable
                      as DeliveryModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of DrivingLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryModelCopyWith<$Res>? get delivery {
    if (_value.delivery == null) {
      return null;
    }

    return $DeliveryModelCopyWith<$Res>(_value.delivery!, (value) {
      return _then(_value.copyWith(delivery: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DrivingLicenseModelImplCopyWith<$Res>
    implements $DrivingLicenseModelCopyWith<$Res> {
  factory _$$DrivingLicenseModelImplCopyWith(
    _$DrivingLicenseModelImpl value,
    $Res Function(_$DrivingLicenseModelImpl) then,
  ) = __$$DrivingLicenseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'licenseNumber') String drivingLicenseNumber,
    @JsonKey(name: 'category') String category,
    String governorate,
    String licensingUnit,
    String issueDate,
    String expiryDate,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    LicenseStatus status,
    String citizenName,
    bool hasUnpaidViolations,
    DeliveryModel? delivery,
  });

  @override
  $DeliveryModelCopyWith<$Res>? get delivery;
}

/// @nodoc
class __$$DrivingLicenseModelImplCopyWithImpl<$Res>
    extends _$DrivingLicenseModelCopyWithImpl<$Res, _$DrivingLicenseModelImpl>
    implements _$$DrivingLicenseModelImplCopyWith<$Res> {
  __$$DrivingLicenseModelImplCopyWithImpl(
    _$DrivingLicenseModelImpl _value,
    $Res Function(_$DrivingLicenseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? drivingLicenseNumber = null,
    Object? category = null,
    Object? governorate = null,
    Object? licensingUnit = null,
    Object? issueDate = null,
    Object? expiryDate = null,
    Object? status = null,
    Object? citizenName = null,
    Object? hasUnpaidViolations = null,
    Object? delivery = freezed,
  }) {
    return _then(
      _$DrivingLicenseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        drivingLicenseNumber: null == drivingLicenseNumber
            ? _value.drivingLicenseNumber
            : drivingLicenseNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        governorate: null == governorate
            ? _value.governorate
            : governorate // ignore: cast_nullable_to_non_nullable
                  as String,
        licensingUnit: null == licensingUnit
            ? _value.licensingUnit
            : licensingUnit // ignore: cast_nullable_to_non_nullable
                  as String,
        issueDate: null == issueDate
            ? _value.issueDate
            : issueDate // ignore: cast_nullable_to_non_nullable
                  as String,
        expiryDate: null == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as LicenseStatus,
        citizenName: null == citizenName
            ? _value.citizenName
            : citizenName // ignore: cast_nullable_to_non_nullable
                  as String,
        hasUnpaidViolations: null == hasUnpaidViolations
            ? _value.hasUnpaidViolations
            : hasUnpaidViolations // ignore: cast_nullable_to_non_nullable
                  as bool,
        delivery: freezed == delivery
            ? _value.delivery
            : delivery // ignore: cast_nullable_to_non_nullable
                  as DeliveryModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DrivingLicenseModelImpl extends _DrivingLicenseModel {
  const _$DrivingLicenseModelImpl({
    this.id = 0,
    @JsonKey(name: 'licenseNumber') this.drivingLicenseNumber = '',
    @JsonKey(name: 'category') this.category = '',
    this.governorate = '',
    this.licensingUnit = '',
    this.issueDate = '',
    this.expiryDate = '',
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    this.status = LicenseStatus.valid,
    this.citizenName = '',
    this.hasUnpaidViolations = false,
    this.delivery,
  }) : super._();

  factory _$DrivingLicenseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrivingLicenseModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'licenseNumber')
  final String drivingLicenseNumber;
  @override
  @JsonKey(name: 'category')
  final String category;
  @override
  @JsonKey()
  final String governorate;
  @override
  @JsonKey()
  final String licensingUnit;
  @override
  @JsonKey()
  final String issueDate;
  @override
  @JsonKey()
  final String expiryDate;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  final LicenseStatus status;
  @override
  @JsonKey()
  final String citizenName;
  @override
  @JsonKey()
  final bool hasUnpaidViolations;
  @override
  final DeliveryModel? delivery;

  @override
  String toString() {
    return 'DrivingLicenseModel(id: $id, drivingLicenseNumber: $drivingLicenseNumber, category: $category, governorate: $governorate, licensingUnit: $licensingUnit, issueDate: $issueDate, expiryDate: $expiryDate, status: $status, citizenName: $citizenName, hasUnpaidViolations: $hasUnpaidViolations, delivery: $delivery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrivingLicenseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.drivingLicenseNumber, drivingLicenseNumber) ||
                other.drivingLicenseNumber == drivingLicenseNumber) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.governorate, governorate) ||
                other.governorate == governorate) &&
            (identical(other.licensingUnit, licensingUnit) ||
                other.licensingUnit == licensingUnit) &&
            (identical(other.issueDate, issueDate) ||
                other.issueDate == issueDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.citizenName, citizenName) ||
                other.citizenName == citizenName) &&
            (identical(other.hasUnpaidViolations, hasUnpaidViolations) ||
                other.hasUnpaidViolations == hasUnpaidViolations) &&
            (identical(other.delivery, delivery) ||
                other.delivery == delivery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    drivingLicenseNumber,
    category,
    governorate,
    licensingUnit,
    issueDate,
    expiryDate,
    status,
    citizenName,
    hasUnpaidViolations,
    delivery,
  );

  /// Create a copy of DrivingLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrivingLicenseModelImplCopyWith<_$DrivingLicenseModelImpl> get copyWith =>
      __$$DrivingLicenseModelImplCopyWithImpl<_$DrivingLicenseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DrivingLicenseModelImplToJson(this);
  }
}

abstract class _DrivingLicenseModel extends DrivingLicenseModel {
  const factory _DrivingLicenseModel({
    final int id,
    @JsonKey(name: 'licenseNumber') final String drivingLicenseNumber,
    @JsonKey(name: 'category') final String category,
    final String governorate,
    final String licensingUnit,
    final String issueDate,
    final String expiryDate,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    final LicenseStatus status,
    final String citizenName,
    final bool hasUnpaidViolations,
    final DeliveryModel? delivery,
  }) = _$DrivingLicenseModelImpl;
  const _DrivingLicenseModel._() : super._();

  factory _DrivingLicenseModel.fromJson(Map<String, dynamic> json) =
      _$DrivingLicenseModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'licenseNumber')
  String get drivingLicenseNumber;
  @override
  @JsonKey(name: 'category')
  String get category;
  @override
  String get governorate;
  @override
  String get licensingUnit;
  @override
  String get issueDate;
  @override
  String get expiryDate;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  LicenseStatus get status;
  @override
  String get citizenName;
  @override
  bool get hasUnpaidViolations;
  @override
  DeliveryModel? get delivery;

  /// Create a copy of DrivingLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrivingLicenseModelImplCopyWith<_$DrivingLicenseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
