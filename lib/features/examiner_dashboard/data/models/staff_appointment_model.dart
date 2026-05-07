class StaffAppointmentModel {
  final String? citizenNationalId;
  final int? applicationId;
  final String? type;
  final String? typeName;
  final String? serviceName;
  final String? date;
  final String? dateFormatted;
  final String? startTime;
  final String? timeFormatted;
  final String? endTime;
  final String? status;
  final String? createdAt;
  final String? completedAt;
  final String? requestNumberRelated;
  final String? assignedToUserId;
  final String? governorateName;
  final String? trafficUnitName;

  StaffAppointmentModel({
    this.citizenNationalId,
    this.applicationId,
    this.type,
    this.typeName,
    this.serviceName,
    this.date,
    this.dateFormatted,
    this.startTime,
    this.timeFormatted,
    this.endTime,
    this.status,
    this.createdAt,
    this.completedAt,
    this.requestNumberRelated,
    this.assignedToUserId,
    this.governorateName,
    this.trafficUnitName,
  });

  String get displayDate {
    if (dateFormatted != null && dateFormatted!.isNotEmpty) return dateFormatted!;
    return date ?? '-';
  }

  String get displayTime {
    if (timeFormatted != null && timeFormatted!.isNotEmpty) return timeFormatted!;
    if (startTime != null && endTime != null) return '$startTime - $endTime';
    return startTime ?? '-';
  }

  factory StaffAppointmentModel.fromJson(Map<String, dynamic> json) {
    return StaffAppointmentModel(
      citizenNationalId: json['citizenNationalId']?.toString(),
      applicationId: json['applicationId'] as int?,
      type: json['type']?.toString(),
      typeName: json['typeName']?.toString(),
      serviceName: json['serviceName']?.toString(),
      date: json['date']?.toString(),
      dateFormatted: json['dateFormatted']?.toString(),
      startTime: json['startTime']?.toString(),
      timeFormatted: json['timeFormatted']?.toString(),
      endTime: json['endTime']?.toString(),
      status: json['status']?.toString(),
      createdAt: json['createdAt']?.toString(),
      completedAt: json['completedAt']?.toString(),
      requestNumberRelated: json['requestNumberRelated']?.toString(),
      assignedToUserId: json['assignedToUserId']?.toString(),
      governorateName: json['governorateName']?.toString(),
      trafficUnitName: json['trafficUnitName']?.toString(),
    );
  }
}
