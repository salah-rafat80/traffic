import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String baseUrl = 'http://morourak.runasp.net/api/v1';

  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    ));
    dio.interceptors.add(_AuthInterceptor());
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for public endpoints
    final publicPaths = [
      '/Auth/register',
      '/Auth/verify-otp',
      '/Auth/login',
      '/Auth/forgot-password',
      '/Auth/reset-password',
      '/VehicleTypes',
      '/appointments/available-slots',
      '/governorates',
      '/VehicleLicense/insurance-companies',
    ];

    final isPublic = publicPaths.any(
      (path) => options.path.contains(path),
    );

    if (!isPublic) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        // Printing the token to the terminal for the user to copy
        print('\n=== ACCESS TOKEN ===\n$token\n====================\n');
        debugPrint('AuthInterceptor: Added token for ${options.path}');
      } else {
        debugPrint('AuthInterceptor: NO TOKEN found for ${options.path}');
      }
    }

    handler.next(options);
  }
}
