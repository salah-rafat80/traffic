import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/profile/data/models/profile_model.dart';

class ProfileCache {
  static const String _profileKey = 'cached_user_profile';

  /// Saves the [ProfileModel] to local storage as a JSON string.
  Future<void> saveProfile(ProfileModel profile) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = {
      'fullName': profile.fullName,
      'nationalId': profile.nationalId,
      'phoneNumber': profile.phoneNumber,
      'email': profile.email,
    };
    await prefs.setString(_profileKey, jsonEncode(data));
  }

  /// Retrieves the cached [ProfileModel] from local storage.
  /// Returns null if no profile is cached.
  Future<ProfileModel?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_profileKey);
    
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final Map<String, dynamic> data = jsonDecode(jsonString);
        return ProfileModel(
          fullName: data['fullName'] ?? '',
          nationalId: data['nationalId'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          email: data['email'] ?? '',
        );
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// Clears the cached profile data from local storage.
  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileKey);
  }
}
