/// Holds the applicant's personal data displayed in [ApplicantDetailsCard].
class ApplicantDetails {
  final String name;
  final String nationalId;
  final String phone;
  final String email;

  const ApplicantDetails({
    required this.name,
    required this.nationalId,
    required this.phone,
    required this.email,
  });
}
