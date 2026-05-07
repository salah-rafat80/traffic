import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/profile_cache.dart';
import '../../../../core/api/token_storage.dart';

@lazySingleton
class AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthRepository(this._apiClient, this._tokenStorage);

  Future<(String? error, List<String>? roles)> login(String mobileNumber, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/Auth/login',
        data: {
          'mobileNumber': mobileNumber,
          'password': password,
        },
      );

      final data = response.data;
      debugPrint('✅ Login response: $data');

      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess && data['details'] != null && data['details'] is Map) {
          final details = data['details'] as Map<String, dynamic>;
          final token = details['token'] as String?;

          if (token != null && token.isNotEmpty) {
            await _tokenStorage.saveToken(token);
            
            // Save roles if available
            final roles = details['roles'] as List?;
            final rolesList = roles?.map((e) => e.toString()).toList() ?? [];
            if (rolesList.isNotEmpty) {
              await _tokenStorage.saveRoles(rolesList);
            }
            
            return (null, rolesList); // Return null on success
          }
        }
        
        final message = data['message'] as String?;
        return (message ?? 'فشل تسجيل الدخول. تأكد من صحة البيانات.', null);
      }
      
      return ('لم يتم استلام رد صحيح من السيرفر', null);
    } on DioException catch (e) {
      ApiErrorHandler.logError('Login', e);
      return (ApiErrorHandler.extractMessage(e, fallback: 'فشل تسجيل الدخول. تأكد من صحة البيانات.'), null);
    } catch (e) {
      return ('حدث خطأ غير متوقع.', null);
    }
  }

  Future<String?> register({
    required String nationalId,
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/Auth/register',
        data: {
          'nationalId': nationalId,
          'mobileNumber': mobileNumber,
          'firstName': firstName,
          'lastName': lastName,
          'Email': email,
          'username': username,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess) {
          return null; // Success
        }
        return data['message']?.toString() ?? 'فشل إنشاء الحساب.';
      }
      
      return null; // Default success if no body but 200 OK
    } on DioException catch (e) {
      ApiErrorHandler.logError('Register', e);
      return ApiErrorHandler.extractMessage(e, fallback: 'فشل إنشاء الحساب.');
    } catch (e) {
      debugPrint('Register unexpected error: $e');
      return 'حدث خطأ غير متوقع.';
    }
  }

  Future<String?> verifyOtp(String email, String code) async {
    try {
      final response = await _apiClient.dio.post(
        '/Auth/verify-otp',
        data: {
          'email': email,
          'code': code,
        },
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess) {
          return null; // Success
        }
        return data['message']?.toString() ?? 'رمز التحقق غير صحيح.';
      }

      return null; // 200 OK without body = success
    } on DioException catch (e) {
      ApiErrorHandler.logError('VerifyOtp', e);
      return ApiErrorHandler.extractMessage(e, fallback: 'فشل التحقق من الرمز.');
    } catch (e) {
      debugPrint('Verify OTP unexpected error: $e');
      return 'حدث خطأ غير متوقع.';
    }
  }

  Future<bool> hasToken() async {
    return await _tokenStorage.hasToken();
  }

  Future<List<String>> getRoles() async {
    return await _tokenStorage.getRoles();
  }

  Future<void> logout() async {
    await _tokenStorage.clearAll();
    await ProfileCache().clearProfile();
  }
}
