import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  static const String _tokenKey = 'auth_token';
  static const String _rolesKey = 'user_roles';

  Future<void> _ensurePrefs() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint('TokenStorage: Failed to initialize SharedPreferences: $e');
    }
  }

  Future<void> saveToken(String token) async {
    try {
      if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
        await _ensurePrefs();
        await _prefs?.setString(_tokenKey, token);
      } else {
        await _storage.write(key: _tokenKey, value: token);
      }
    } catch (e) {
      debugPrint('Error saving token: $e');
      // Fallback to prefs if secure storage fails
      await _ensurePrefs();
      await _prefs?.setString(_tokenKey, token);
    }
  }

  Future<String?> getToken() async {
    try {
      if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
        await _ensurePrefs();
        return _prefs?.getString(_tokenKey);
      }
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      debugPrint('Error reading token: $e');
      await _ensurePrefs();
      return _prefs?.getString(_tokenKey);
    }
  }

  Future<void> saveRoles(List<String> roles) async {
    try {
      final rolesStr = roles.join(',');
      if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
        await _ensurePrefs();
        await _prefs?.setString(_rolesKey, rolesStr);
      } else {
        await _storage.write(key: _rolesKey, value: rolesStr);
      }
    } catch (e) {
      debugPrint('Error saving roles: $e');
      await _ensurePrefs();
      await _prefs?.setString(_rolesKey, roles.join(','));
    }
  }

  Future<List<String>> getRoles() async {
    try {
      String? rolesStr;
      if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
        await _ensurePrefs();
        rolesStr = _prefs?.getString(_rolesKey);
      } else {
        rolesStr = await _storage.read(key: _rolesKey);
      }
      
      if (rolesStr == null || rolesStr.isEmpty) return [];
      return rolesStr.split(',');
    } catch (e) {
      debugPrint('Error reading roles: $e');
      await _ensurePrefs();
      final rolesStr = _prefs?.getString(_rolesKey);
      return (rolesStr == null || rolesStr.isEmpty) ? [] : rolesStr.split(',');
    }
  }

  Future<void> clearAll() async {
    try {
      await _ensurePrefs();
      await _prefs?.remove(_tokenKey);
      await _prefs?.remove(_rolesKey);
      
      if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
        await _storage.delete(key: _tokenKey);
        await _storage.delete(key: _rolesKey);
      }
    } catch (e) {
      debugPrint('Error clearing storage: $e');
    }
  }

  Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking token existence: $e');
      return false;
    }
  }
}
