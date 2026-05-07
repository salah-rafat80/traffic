/// Response model returned by POST /VehicleLicense/finalize/{requestNumber}.
class VehicleLicenseFinalizeResponseModel {
  final String requestNumber;
  final VehicleFinalizeFees? fees;

  const VehicleLicenseFinalizeResponseModel({
    required this.requestNumber,
    this.fees,
  });

  factory VehicleLicenseFinalizeResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    // requestNumber may be in the response body or in RequestIdManager
    final requestNumber =
        json['requestNumber'] as String? ??
        json['serviceRequestNumber'] as String? ??
        '';

    final feesMap = json['fees'] as Map<String, dynamic>?;

    return VehicleLicenseFinalizeResponseModel(
      requestNumber: requestNumber,
      fees: feesMap != null ? VehicleFinalizeFees.fromJson(feesMap) : null,
    );
  }
}

class VehicleFinalizeFees {
  final double baseFee;
  final double deliveryFee;
  final double totalAmount;

  const VehicleFinalizeFees({
    required this.baseFee,
    required this.deliveryFee,
    required this.totalAmount,
  });

  factory VehicleFinalizeFees.fromJson(Map<String, dynamic> json) {
    return VehicleFinalizeFees(
      baseFee: (json['baseFee'] as num? ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] as num? ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] as num? ?? 0).toDouble(),
    );
  }
}
