import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  /// Fetches the authenticated citizen's profile.
  Future<ApiResult<ProfileModel>> getProfile() async {
    try {
      final response = await _apiClient.dio.get('/auth/profile');
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final profileResponse = ProfileResponse.fromJson(data);

        if (profileResponse.isSuccess && profileResponse.details != null) {
          return ApiResult.success(profileResponse.details!);
        }

        return ApiResult.failure(profileResponse.message ?? 'لم يتم استلام بيانات الملف الشخصي');
      }

      return ApiResult.failure('رد غير متوقع من السيرفر');
    } on DioException catch (e) {
      ApiErrorHandler.logError('GetProfile', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Requests an email change — sends an OTP to [newEmail].
  Future<ApiResult<void>> requestEmailChange({
    required String newEmail,
  }) async {
    try {
      await _apiClient.dio.post(
        '/auth/change-email/request',
        data: {'newEmail': newEmail},
      );
      return ApiResult.success();
    } on DioException catch (e) {
      ApiErrorHandler.logError('RequestEmailChange', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Confirms the email change with the OTP code.
  Future<ApiResult<void>> confirmEmailChange({
    required String newEmail,
    required String code,
  }) async {
    try {
      await _apiClient.dio.post(
        '/auth/change-email/confirm',
        data: {
          'newEmail': newEmail,
          'code': code,
        },
      );
      return ApiResult.success();
    } on DioException catch (e) {
      ApiErrorHandler.logError('ConfirmEmailChange', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Initiates password reset flow by requesting an OTP.
  Future<ApiResult<void>> forgotPassword(String email) async {
    try {
      final response = await _apiClient.dio.post(
        '/Auth/forgot-password',
        data: {'email': email},
      );
      
      final data = response.data;
      if (data is Map<String, dynamic> && data['isSuccess'] == true) {
        return ApiResult.success();
      }
      final errorMessage = (data is Map<String, dynamic>) ? data['message'] as String? : null;
      return ApiResult.failure(errorMessage ?? 'فشل إرسال رمز التحقق');
    } on DioException catch (e) {
      ApiErrorHandler.logError('ForgotPassword', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Finalizes password reset using the OTP code.
  Future<ApiResult<void>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/Auth/reset-password',
        data: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['isSuccess'] == true) {
        return ApiResult.success();
      }
      final errorMessage = (data is Map<String, dynamic>) ? data['message'] as String? : null;
      return ApiResult.failure(errorMessage ?? 'فشل تغيير كلمة المرور');
    } on DioException catch (e) {
      ApiErrorHandler.logError('ResetPassword', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }
}
