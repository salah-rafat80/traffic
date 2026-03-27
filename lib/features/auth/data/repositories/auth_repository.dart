import 'package:dio/dio.dart';
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
         if (e.response?.data is Map && e.response!.data['message'] != null) {
            return e.response!.data['message'].toString();
         }
      }
      return 'فشل تسجيل الدخول. تأكد من صحة البيانات.';
    } catch (e) {
      return 'حدث خطأ غير متوقع.';
    }
  }
}

