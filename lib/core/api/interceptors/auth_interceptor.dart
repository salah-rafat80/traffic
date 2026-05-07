import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // 1. Add Idempotency-Key for all POST requests
      if (options.method == 'POST') {
        options.headers['Idempotency-Key'] = const Uuid().v4();
      }

      // 2. Skip auth for public endpoints
      final publicPaths = [
        '/Auth/register',
        '/Auth/verify-otp',
        '/Auth/login',
        '/VehicleTypes',
        '/appointments/available-slots',
        '/governorates',
        '/VehicleLicense/insurance-companies',
      ];

      final isPublic = publicPaths.any(
        (path) => options.path.contains(path),
      );

      if (!isPublic) {
        final token = await _tokenStorage.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          debugPrint('AuthInterceptor: Added token for ${options.path}');
        }
      }

      handler.next(options);
    } catch (e) {
      debugPrint('❌ AuthInterceptor Error: $e');
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      debugPrint('❌ AuthInterceptor: 401 Unauthorized - Token may be expired');
      // Here you could handle token refresh or force logout
    }
    super.onError(err, handler);
  }
}
