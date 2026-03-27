import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://morourak.runasp.net/api/v1',
    headers: {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    },
  ));

  Future<String?> login(String mobileNumber, String password) async {
    try {
      final response = await _dio.post(
        '/Auth/login',
        data: {
          'mobileNumber': mobileNumber,
          'password': password,
        },
      );

      final data = response.data;
      String? token;
      
      if (data is Map<String, dynamic>) {
        token = data['token'] as String?;
      } else if (data is String) {
        // sometimes auth returns token as string
        token = data;
      }

      if (token != null && token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return null; // Return null on success
      }
      
      return 'لم يتم استلام رمز مرور صحيح';
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
      await _dio.post(
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
      final response = await _dio.post(
        '/Auth/verify-otp',
        data: {
          'email': email,
          'code': code,
        },
      );

      final data = response.data;
      String? token;
      
      if (data is Map<String, dynamic>) {
        token = data['token'] as String?;
      } else if (data is String) {
        token = data;
      }

      if (token != null && token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return null; // Return null on success
      }
      
      return 'رمز التحقق غير صحيح.';
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
}

