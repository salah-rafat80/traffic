// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_license_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VehicleLicenseModel _$VehicleLicenseModelFromJson(Map<String, dynamic> json) {
  return _VehicleLicenseModel.fromJson(json);
}

/// @nodoc
mixin _$VehicleLicenseModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicleLicenseNumber')
  String get vehicleLicenseNumber => throw _privateConstructorUsedError;
  String? get plateNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String get category => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  String get governorate => throw _privateConstructorUsedError;
  String get licensingUnit => throw _privateConstructorUsedError;
  String get issueDate => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  LicenseStatus get status => throw _privateConstructorUsedError;
  String get citizenName => throw _privateConstructorUsedError;
  bool get hasUnpaidViolations => throw _privateConstructorUsedError;
  DeliveryModel? get delivery => throw _privateConstructorUsedError;

  /// Serializes this VehicleLicenseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleLicenseModelCopyWith<VehicleLicenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleLicenseModelCopyWith<$Res> {
  factory $VehicleLicenseModelCopyWith(
    VehicleLicenseModel value,
    $Res Function(VehicleLicenseModel) then,
  ) = _$VehicleLicenseModelCopyWithImpl<$Res, VehicleLicenseModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'vehicleLicenseNumber') String vehicleLicenseNumber,
    String? plateNumber,
    @JsonKey(name: 'category') String category,
    String brand,
    String model,
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
class _$VehicleLicenseModelCopyWithImpl<$Res, $Val extends VehicleLicenseModel>
    implements $VehicleLicenseModelCopyWith<$Res> {
  _$VehicleLicenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicleLicenseNumber = null,
    Object? plateNumber = freezed,
    Object? category = null,
    Object? brand = null,
    Object? model = null,
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
            vehicleLicenseNumber: null == vehicleLicenseNumber
                ? _value.vehicleLicenseNumber
                : vehicleLicenseNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            plateNumber: freezed == plateNumber
                ? _value.plateNumber
                : plateNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            brand: null == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String,
            model: null == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of VehicleLicenseModel
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
abstract class _$$VehicleLicenseModelImplCopyWith<$Res>
    implements $VehicleLicenseModelCopyWith<$Res> {
  factory _$$VehicleLicenseModelImplCopyWith(
    _$VehicleLicenseModelImpl value,
    $Res Function(_$VehicleLicenseModelImpl) then,
  ) = __$$VehicleLicenseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'vehicleLicenseNumber') String vehicleLicenseNumber,
    String? plateNumber,
    @JsonKey(name: 'category') String category,
    String brand,
    String model,
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
class __$$VehicleLicenseModelImplCopyWithImpl<$Res>
    extends _$VehicleLicenseModelCopyWithImpl<$Res, _$VehicleLicenseModelImpl>
    implements _$$VehicleLicenseModelImplCopyWith<$Res> {
  __$$VehicleLicenseModelImplCopyWithImpl(
    _$VehicleLicenseModelImpl _value,
    $Res Function(_$VehicleLicenseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VehicleLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicleLicenseNumber = null,
    Object? plateNumber = freezed,
    Object? category = null,
    Object? brand = null,
    Object? model = null,
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
      _$VehicleLicenseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        vehicleLicenseNumber: null == vehicleLicenseNumber
            ? _value.vehicleLicenseNumber
            : vehicleLicenseNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        plateNumber: freezed == plateNumber
            ? _value.plateNumber
            : plateNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        brand: null == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String,
        model: null == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
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
class _$VehicleLicenseModelImpl extends _VehicleLicenseModel {
  const _$VehicleLicenseModelImpl({
    this.id = 0,
    @JsonKey(name: 'vehicleLicenseNumber') this.vehicleLicenseNumber = '',
    this.plateNumber,
    @JsonKey(name: 'category') this.category = '',
    this.brand = '',
    this.model = '',
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

  factory _$VehicleLicenseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleLicenseModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'vehicleLicenseNumber')
  final String vehicleLicenseNumber;
  @override
  final String? plateNumber;
  @override
  @JsonKey(name: 'category')
  final String category;
  @override
  @JsonKey()
  final String brand;
  @override
  @JsonKey()
  final String model;
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
    return 'VehicleLicenseModel(id: $id, vehicleLicenseNumber: $vehicleLicenseNumber, plateNumber: $plateNumber, category: $category, brand: $brand, model: $model, governorate: $governorate, licensingUnit: $licensingUnit, issueDate: $issueDate, expiryDate: $expiryDate, status: $status, citizenName: $citizenName, hasUnpaidViolations: $hasUnpaidViolations, delivery: $delivery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleLicenseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicleLicenseNumber, vehicleLicenseNumber) ||
                other.vehicleLicenseNumber == vehicleLicenseNumber) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
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
    vehicleLicenseNumber,
    plateNumber,
    category,
    brand,
    model,
    governorate,
    licensingUnit,
    issueDate,
    expiryDate,
    status,
    citizenName,
    hasUnpaidViolations,
    delivery,
  );

  /// Create a copy of VehicleLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleLicenseModelImplCopyWith<_$VehicleLicenseModelImpl> get copyWith =>
      __$$VehicleLicenseModelImplCopyWithImpl<_$VehicleLicenseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleLicenseModelImplToJson(this);
  }
}

abstract class _VehicleLicenseModel extends VehicleLicenseModel {
  const factory _VehicleLicenseModel({
    final int id,
    @JsonKey(name: 'vehicleLicenseNumber') final String vehicleLicenseNumber,
    final String? plateNumber,
    @JsonKey(name: 'category') final String category,
    final String brand,
    final String model,
    final String governorate,
    final String licensingUnit,
    final String issueDate,
    final String expiryDate,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    final LicenseStatus status,
    final String citizenName,
    final bool hasUnpaidViolations,
    final DeliveryModel? delivery,
  }) = _$VehicleLicenseModelImpl;
  const _VehicleLicenseModel._() : super._();

  factory _VehicleLicenseModel.fromJson(Map<String, dynamic> json) =
      _$VehicleLicenseModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'vehicleLicenseNumber')
  String get vehicleLicenseNumber;
  @override
  String? get plateNumber;
  @override
  @JsonKey(name: 'category')
  String get category;
  @override
  String get brand;
  @override
  String get model;
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

  /// Create a copy of VehicleLicenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleLicenseModelImplCopyWith<_$VehicleLicenseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
