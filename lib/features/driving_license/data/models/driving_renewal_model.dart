import 'package:flutter/foundation.dart';

enum AppointmentType {
  medical('Medical'),
  driving('Driving'),
  technical('Technical');

  final String apiValue;
  const AppointmentType(this.apiValue);

  String get serviceTypeValue {
    switch (this) {
      case AppointmentType.medical:
        return 'كشف طبي';
      case AppointmentType.driving:
        return 'قيادة عملي';
      case AppointmentType.technical:
        return 'فحص فني';
    }
  }
}

@immutable
class LocationLookupModel {
  final String id;
  final String name;

  const LocationLookupModel({required this.id, required this.name});

  factory LocationLookupModel.fromJson(Map<String, Object?> json) {
    final Object? rawId = json['id'] ?? json['governorateId'] ?? json['trafficUnitId'];
    final Object? rawName =
        json['name'] ?? json['governorateName'] ?? json['trafficUnitName'] ?? json['title'];
    return LocationLookupModel(
      id: rawId?.toString() ?? '',
      name: rawName?.toString() ?? '',
    );
  }
}

@immutable
class AppointmentSlotModel {
  final String startTime;
  final String? endTime;
  final bool isAvailable;

  const AppointmentSlotModel({
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  factory AppointmentSlotModel.fromJson(Map<String, Object?> json) {
    final String startTime =
        (json['startTime'] ?? json['time'] ?? json['from'] ?? '').toString();
    final String endTime = (json['endTime'] ?? json['to'] ?? '').toString();
    final bool isAvailable = json['isAvailable'] is bool ? json['isAvailable']! as bool : true;

    return AppointmentSlotModel(
      startTime: startTime,
      endTime: endTime.isEmpty ? null : endTime,
      isAvailable: isAvailable,
    );
  }

  String get displayLabel {
    if (endTime == null || endTime!.isEmpty) {
      return startTime;
    }
    return '$startTime-$endTime';
  }
}

@immutable
class AppointmentBookingRequestModel {
  final String governorateId;
  final String trafficUnitId;
  final AppointmentType type;
  final String? serviceTypeOverride;
  final String date;
  final String startTime;

  const AppointmentBookingRequestModel({
    required this.governorateId,
    required this.trafficUnitId,
    required this.type,
    this.serviceTypeOverride,
    required this.date,
    required this.startTime,
  });

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'governorateId': governorateId,
      'trafficUnitId': trafficUnitId,
      'GovernorateId': governorateId,
      'TrafficUnitId': trafficUnitId,
      'serviceType': serviceTypeOverride ?? type.serviceTypeValue,
      'type': type.apiValue,
      'date': date,
      'time': startTime,
      'startTime': startTime,
    };
  }
}

@immutable
class AppointmentBookingResponseModel {
  final String serviceNumber;
  final String applicationId;
  final String date;
  final String startTime;
  final String status;
  final String type;

  const AppointmentBookingResponseModel({
    required this.serviceNumber,
    required this.applicationId,
    required this.date,
    required this.startTime,
    required this.status,
    required this.type,
  });

  factory AppointmentBookingResponseModel.fromJson(Map<String, Object?> json) {
    return AppointmentBookingResponseModel(
      serviceNumber: (json['serviceNumber'] ?? '').toString(),
      applicationId: (json['applicationId'] ?? '').toString(),
      date: (json['date'] ?? '').toString(),
      startTime: (json['startTime'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
    );
  }
}

/// Snapshot of values currently produced by the renewal UI flow.
///
/// These values are read from existing local widget state and passed as-is to
/// the data handler. Some fields intentionally have no API mapping yet.
@immutable
class RenewalUiSnapshot {
  final bool isTermsAccepted;
  final String? selectedGovernorate;
  final String? selectedTrafficUnit;
  final DateTime? selectedAppointmentDate;
  final String? selectedAppointmentSlot;

  const RenewalUiSnapshot({
    required this.isTermsAccepted,
    required this.selectedGovernorate,
    required this.selectedTrafficUnit,
    required this.selectedAppointmentDate,
    required this.selectedAppointmentSlot,
  });
}

/// Renewal request payload model.
///
/// Based on the strict overlap rule (UI fields ∩ API request fields), the
/// current renewal UI does not provide any request body field consumed by
/// `POST /DrivingLicense/renewal-request`.
@immutable
class RenewalRequestModel {
  const RenewalRequestModel();

  factory RenewalRequestModel.fromUiSnapshot({
    required RenewalUiSnapshot snapshot,
  }) {
    final bool hasAnyUiValue =
        snapshot.isTermsAccepted ||
        snapshot.selectedGovernorate != null ||
        snapshot.selectedTrafficUnit != null ||
        snapshot.selectedAppointmentDate != null ||
        snapshot.selectedAppointmentSlot != null;

    if (hasAnyUiValue) {
      return const RenewalRequestModel();
    }

    return const RenewalRequestModel();
  }

  factory RenewalRequestModel.fromJson(Map<String, Object?> json) {
    if (json.isNotEmpty) {
      return const RenewalRequestModel();
    }

    return const RenewalRequestModel();
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{};
  }
}

/// Renewal response model exposing only fields currently displayed by UI.
///
/// `requestNumber` is already displayed in booking summary UI (currently as a
/// static placeholder), so only that field is exposed.
@immutable
class RenewalResponseModel {
  final String requestNumber;

  const RenewalResponseModel({required this.requestNumber});

  factory RenewalResponseModel.fromJson(Map<String, Object?> json) {
    final Object? rawRequestNumber = json['requestNumber'];
    return RenewalResponseModel(
      requestNumber: rawRequestNumber?.toString() ?? '',
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'requestNumber': requestNumber,
    };
  }
}

/// Field flags for contract mismatches (UI-only and API-only fields).
class RenewalFieldMappingReport {
  static const List<String> uiFieldsWithoutApiMapping = <String>[
    'isTermsAccepted',
    'selectedGovernorate',
    'selectedTrafficUnit',
    'selectedAppointmentDate',
    'selectedAppointmentSlot',
  ];

  static const List<String> apiRequestFieldsWithoutUiSource = <String>[
    'NewCategory',
    'method',
    'address.governorate',
    'address.city',
    'address.details',
  ];

  static const List<String> apiResponseFieldsWithoutUiConsumer = <String>[
    'id',
    'drivingLicenseNumber',
    'currentCategory',
    'requestedCategory',
    'status',
    'category',
    'governorate',
    'licensingUnit',
    'issueDate',
    'expiryDate',
    'citizenName',
    'delivery.method',
    'delivery.address.governorate',
    'delivery.address.city',
    'delivery.address.details',
  ];
}
