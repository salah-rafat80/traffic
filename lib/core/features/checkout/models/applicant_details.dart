import 'package:traffic/core/api/profile_cache.dart';
import 'package:traffic/features/profile/data/repositories/profile_repository.dart';
import 'package:traffic/injection_container.dart';

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

  /// Loads the actual user's details dynamically from the cache or directly from the API.
  static Future<ApplicantDetails> getActualDetails() async {
    try {
      final cached = await ProfileCache().getProfile();
      if (cached != null) {
        return ApplicantDetails(
          name: cached.fullName,
          nationalId: cached.nationalId,
          phone: cached.phoneNumber,
          email: cached.email,
        );
      }
    } catch (_) {}

    try {
      final repo = getIt<ProfileRepository>();
      final result = await repo.getProfile();
      if (result.isSuccess && result.data != null) {
        final profile = result.data!;
        await ProfileCache().saveProfile(profile);
        return ApplicantDetails(
          name: profile.fullName,
          nationalId: profile.nationalId,
          phone: profile.phoneNumber,
          email: profile.email,
        );
      }
    } catch (_) {}

    // Fallback default if all else fails
    return const ApplicantDetails(
      name: 'اميرة عصام حامد',
      nationalId: '010123456789099',
      phone: '01013706488',
      email: 'amirabadreldeen7@icloud.com',
    );
  }
}
