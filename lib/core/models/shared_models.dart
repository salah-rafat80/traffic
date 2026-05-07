import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_models.freezed.dart';
part 'shared_models.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    @Default('') String governorate,
    @Default('') String city,
    @Default('') String details,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@freezed
class DeliveryModel with _$DeliveryModel {
  const factory DeliveryModel({
    @Default('') String method,
    AddressModel? address,
  }) = _DeliveryModel;

  factory DeliveryModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryModelFromJson(json);
}
