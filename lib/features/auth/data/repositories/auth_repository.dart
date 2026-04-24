import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/profile_cache.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<String?> login(String mobileNumber, String password) async {
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
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
            return null; // Return null on success
          }
        }
        
        final message = data['message'] as String?;
        return message ?? 'فشل تسجيل الدخول. تأكد من صحة البيانات.';
      }
      
      return 'لم يتم استلام رد صحيح من السيرفر';
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
         final errorData = e.response!.data;
         if (errorData is Map<String, dynamic> && errorData['message'] != null) {
            return errorData['message'].toString();
         }
      }
      return 'فشل تسجيل الدخول. تأكد من صحة البيانات.';
    } catch (e) {
      return 'حدث خطأ غير متوقع.';
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
      await _apiClient.dio.post(
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
      return null; // Success
    } on DioException catch (e) {
      debugPrint('Register API error: ${e.response?.statusCode}');
      debugPrint('Register API body: ${e.response?.data}');

      if (e.response?.data != null) {
        final errorData = e.response!.data;

        if (errorData is Map<String, dynamic>) {
          // Shape: {"message": "..."}
          if (errorData['message'] != null) {
            return errorData['message'].toString();
          }
          // Shape: {"errors": {"field": ["error1", "error2"]}}
          if (errorData['errors'] != null && errorData['errors'] is Map) {
            final errors = errorData['errors'] as Map;
            final messages = <String>[];
            for (final entry in errors.entries) {
              if (entry.value is List) {
                for (final msg in entry.value as List) {
                  messages.add(msg.toString());
                }
              }
            }
            if (messages.isNotEmpty) {
              return messages.join('\n');
            }
          }
          // Shape: {"title": "...", "detail": "..."}
          if (errorData['detail'] != null) {
            return errorData['detail'].toString();
          }
          if (errorData['title'] != null) {
            return errorData['title'].toString();
          }
        }

        if (errorData is List) {
          return (errorData).map((e) => e.toString()).join('\n');
        }

        if (errorData is String && errorData.isNotEmpty) {
          return errorData;
        }
      }
      return 'فشل إنشاء الحساب. (${e.response?.statusCode ?? 'no status'})';
    } catch (e) {
      debugPrint('Register unexpected error: $e');
      return 'حدث خطأ غير متوقع.';
    }
  }

  Future<String?> verifyOtp(String email, String code) async {
    try {
      debugPrint('=======================================');
      debugPrint('🚀 SENDING OTP VERIFICATION REQUEST:');
      debugPrint('URL: /Auth/verify-otp');
      debugPrint('Payload: { "email": "$email", "code": "$code" }');
      debugPrint('=======================================');

      final response = await _apiClient.dio.post(
        '/Auth/verify-otp',
        data: {
          'email': email,
          'code': code,
        },
      );

      final data = response.data;
      debugPrint('✅ Verify OTP response: $data');

      // API returns: {"isSuccess": true, "message": "...", "details": null}
      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess) {
          return null; // Return null on success
        }
        // If isSuccess is false, return the message from the server
        final message = data['message'] as String?;
        return message ?? 'رمز التحقق غير صحيح.';
      }

      return null; // 200 OK without body = success
    } on DioException catch (e) {
      debugPrint('Verify OTP API error: ${e.response?.statusCode}');
      debugPrint('Verify OTP API body: ${e.response?.data}');

      if (e.response?.data != null) {
        final errorData = e.response!.data;

        if (errorData is Map<String, dynamic>) {
          if (errorData['message'] != null) return errorData['message'].toString();
          if (errorData['detail'] != null) return errorData['detail'].toString();
          if (errorData['title'] != null) return errorData['title'].toString();
        }
        if (errorData is List) return errorData.map((e) => e.toString()).join('\n');
        if (errorData is String && errorData.isNotEmpty) return errorData;
      }
      return 'فشل التحقق من الرمز. (${e.response?.statusCode ?? 'no status'})';
    } catch (e) {
      debugPrint('Verify OTP unexpected error: $e');
      return 'حدث خطأ غير متوقع.';
    }
  }
  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await ProfileCache().clearProfile();
  }
}


