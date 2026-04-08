class DrivingLicenseModel {
  final int id;
  final String drivingLicenseNumber;
  final String category;
  final String governorate;
  final String licensingUnit;
  final String issueDate;
  final String expiryDate;
  final String status;
  final String citizenName;
  final DeliveryModel? delivery;

  const DrivingLicenseModel({
    required this.id,
    required this.drivingLicenseNumber,
    required this.category,
    required this.governorate,
    required this.licensingUnit,
    required this.issueDate,
    required this.expiryDate,
    required this.status,
    required this.citizenName,
    this.delivery,
  });

  factory DrivingLicenseModel.fromJson(Map<String, dynamic> json) {
    return DrivingLicenseModel(
      id: json['id'] as int? ?? 0,
      drivingLicenseNumber: json['drivingLicenseNumber'] as String? ?? '',
      category: json['category'] as String? ?? '',
      governorate: json['governorate'] as String? ?? '',
      licensingUnit: json['licensingUnit'] as String? ?? '',
      issueDate: json['issueDate'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      status: json['status'] as String? ?? '',
      citizenName: json['citizenName'] as String? ?? '',
      delivery: json['delivery'] != null
          ? DeliveryModel.fromJson(json['delivery'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drivingLicenseNumber': drivingLicenseNumber,
      'category': category,
      'governorate': governorate,
      'licensingUnit': licensingUnit,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'status': status,
      'citizenName': citizenName,
      'delivery': delivery?.toJson(),
    };
  }
}

class DeliveryModel {
  final String method;
  final AddressModel? address;

  const DeliveryModel({
    required this.method,
    this.address,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      method: json['method'] as String? ?? '',
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'address': address?.toJson(),
    };
  }
}

class AddressModel {
  final String governorate;
  final String city;
  final String details;

  const AddressModel({
    required this.governorate,
    required this.city,
    required this.details,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      governorate: json['governorate'] as String? ?? '',
      city: json['city'] as String? ?? '',
      details: json['details'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governorate': governorate,
      'city': city,
      'details': details,
    };
  }
}
