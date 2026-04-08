class ProfileResponse {
  final bool isSuccess;
  final String? message;
  final String? errorCode;
  final ProfileModel? details;
  final dynamic errors;

  ProfileResponse({
    required this.isSuccess,
    this.message,
    this.errorCode,
    this.details,
    this.errors,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      isSuccess: json['isSuccess'] as bool? ?? false,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      details: json['details'] != null
          ? ProfileModel.fromJson(json['details'] as Map<String, dynamic>)
          : null,
      errors: json['errors'],
    );
  }
}

class ProfileModel {
  final String fullName;
  final String nationalId;
  final String phoneNumber;
  final String email;

  const ProfileModel({
    required this.fullName,
    required this.nationalId,
    required this.phoneNumber,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: (json['fullName'] as String?) ?? '',
      nationalId: (json['nationalId'] as String?) ?? '',
      phoneNumber: (json['phoneNumber'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
    );
  }
}
