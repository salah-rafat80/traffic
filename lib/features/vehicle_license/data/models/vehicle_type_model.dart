/// Models for GET /VehicleTypes response.
///
/// Backend-allowed VehicleType enum values:
/// PrivateCar, Truck, Taxi, Motorcycle, Bus, PrivateBus, Trailer
///
/// Each vehicle type contains brands, and each brand contains models.
/// VehicleType.value is the integer enum sent to the backend.
class VehicleTypeModel {
  final int value;
  final String name;
  final String nameAr;
  final List<VehicleBrandModel> brands;

  const VehicleTypeModel({
    required this.value,
    required this.name,
    required this.nameAr,
    required this.brands,
  });

  /// Display name for UI (Arabic preferred).
  String get displayName => nameAr.isNotEmpty ? nameAr : name;

  /// All brand Arabic names for this type.
  List<String> get brandNames =>
      brands.map((b) => b.displayName).toList();

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    final brandsJson = json['brands'] as List<dynamic>? ?? [];
    return VehicleTypeModel(
      value: json['value'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      brands: brandsJson
          .map((b) => VehicleBrandModel.fromJson(b as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Fallback list used when GET /VehicleTypes fails.
  /// Values match backend-allowed enum names exactly.
  static List<VehicleTypeModel> get fallbackTypes => const [
        VehicleTypeModel(
          value: 0,
          name: 'PrivateCar',
          nameAr: 'ملاكي',
          brands: [],
        ),
        VehicleTypeModel(
          value: 1,
          name: 'Truck',
          nameAr: 'نقل',
          brands: [],
        ),
        VehicleTypeModel(
          value: 2,
          name: 'Taxi',
          nameAr: 'أجرة',
          brands: [],
        ),
        VehicleTypeModel(
          value: 3,
          name: 'Motorcycle',
          nameAr: 'دراجة نارية',
          brands: [],
        ),
        VehicleTypeModel(
          value: 4,
          name: 'Bus',
          nameAr: 'أتوبيس',
          brands: [],
        ),
        VehicleTypeModel(
          value: 5,
          name: 'PrivateBus',
          nameAr: 'أتوبيس خاص',
          brands: [],
        ),
        VehicleTypeModel(
          value: 6,
          name: 'Trailer',
          nameAr: 'مقطورة',
          brands: [],
        ),
      ];
}

class VehicleBrandModel {
  final String name;
  final String nameAr;
  final List<VehicleModelItem> models;

  const VehicleBrandModel({
    required this.name,
    required this.nameAr,
    required this.models,
  });

  String get displayName => nameAr.isNotEmpty ? nameAr : name;

  List<String> get modelNames =>
      models.map((m) => m.displayName).toList();

  factory VehicleBrandModel.fromJson(Map<String, dynamic> json) {
    final modelsJson = json['models'] as List<dynamic>? ?? [];
    return VehicleBrandModel(
      name: json['name'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      models: modelsJson
          .map((m) => VehicleModelItem.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}

class VehicleModelItem {
  final String name;
  final String nameAr;

  const VehicleModelItem({required this.name, required this.nameAr});

  String get displayName => nameAr.isNotEmpty ? nameAr : name;

  factory VehicleModelItem.fromJson(Map<String, dynamic> json) {
    return VehicleModelItem(
      name: json['name'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
    );
  }
}

/// Model for GET /VehicleLicense/insurance-companies response.
class InsuranceCompanyModel {
  final int id;
  final String name;
  final String nameAr;
  final double fee;
  final String description;
  final String descriptionAr;
  final String? logoPath;

  const InsuranceCompanyModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.fee,
    required this.description,
    required this.descriptionAr,
    this.logoPath,
  });

  String get displayName => nameAr.isNotEmpty ? nameAr : name;
  String get displayDescription =>
      descriptionAr.isNotEmpty ? descriptionAr : description;

  factory InsuranceCompanyModel.fromJson(Map<String, dynamic> json) {
    return InsuranceCompanyModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      fee: (json['fee'] as num? ?? 0).toDouble(),
      description: json['description'] as String? ?? '',
      descriptionAr: json['descriptionAr'] as String? ?? '',
      logoPath: json['logoPath'] as String?,
    );
  }

  /// Converts to the legacy Map format used by InsuranceCompanyCard.
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': displayName,
        'details': displayDescription,
        'fee': fee,
        'logoPath': logoPath,
      };
}
