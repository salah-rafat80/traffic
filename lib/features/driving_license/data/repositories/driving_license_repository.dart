import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';
import '../models/driving_license_model.dart';

class DrivingLicenseRepository {
  final ApiClient _apiClient;

  DrivingLicenseRepository(this._apiClient);

  /// Uploads documents for First-Time Driving License Issuance using multipart/form-data.
  Future<ApiResult<String>> uploadDocuments({
    required String category,
    required String governorate,
    required String licensingUnit,
    required String personalPhotoPath,
    required String idCardPath,
    required String educationalCertificatePath,
    String? residenceProofPath,
  }) async {
    try {
      final dataMap = {
        'category': category,
        'governorate': governorate,
        'licensingUnit': licensingUnit,
        'personalPhoto': await MultipartFile.fromFile(personalPhotoPath),
        'idCard': await MultipartFile.fromFile(idCardPath),
        'educationalCertificate': await MultipartFile.fromFile(educationalCertificatePath),
      };

      if (residenceProofPath != null) {
        dataMap['residenceProof'] = await MultipartFile.fromFile(residenceProofPath);
      }

      final formData = FormData.fromMap(dataMap);

      final response = await _apiClient.dio.post(
        '/DrivingLicense/upload-documents',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final data = response.data;
      // Depending on API, requestNumber might be nested in `details` or at root.
      // E.g., { "isSuccess": true, "details": { "requestNumber": "..." } } or root.
      if (data is Map<String, dynamic>) {
        if (data['requestNumber'] != null) {
          return ApiResult.success(data['requestNumber'].toString());
        } else if (data['details'] != null && data['details'] is Map) {
          final details = data['details'] as Map;
          if (details['requestNumber'] != null) {
            return ApiResult.success(details['requestNumber'].toString());
          }
        }
      }

      return ApiResult.failure('لم يتم استلام رقم الطلب. الرجاء المحاولة مرة أخرى.');
    } on DioException catch (e) {
      ApiErrorHandler.logError('DrivingLicenseUploadDocuments', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Finalizes the driving license application by confirming delivery.
  Future<ApiResult<DrivingLicenseModel>> finalizeDrivingLicense({
    required String requestNumber,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'method': method,
      };

      if (method == 2) {
        // HomeDelivery
        body['address'] = {
          'governorate': governorate,
          'city': city,
          'details': details,
        };
      }

      final response = await _apiClient.dio.post(
        '/DrivingLicense/finalize/$requestNumber',
        data: body,
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess && data['details'] != null && data['details'] is Map) {
          return ApiResult.success(DrivingLicenseModel.fromJson(data['details'] as Map<String, dynamic>));
        } else if (isSuccess) {
           return ApiResult.success(DrivingLicenseModel.fromJson(data));
        }
        
        // Handle fallback if data isn't wrapped
        if (!data.containsKey('isSuccess')) {
           return ApiResult.success(DrivingLicenseModel.fromJson(data));
        }
        
        return ApiResult.failure(data['message']?.toString() ?? 'لم يتم استلام بيانات الرخصة النهائية');
      }

      return ApiResult.failure('لم يتم استلام بيانات الرخصة النهائية');
    } on DioException catch (e) {
      ApiErrorHandler.logError('FinalizeDrivingLicense', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Fetches all driving licenses for the authenticated citizen.
  Future<ApiResult<List<DrivingLicenseModel>>> getMyLicenses() async {
    try {
      final response = await _apiClient.dio.get('/DrivingLicense/my-licenses');
      
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess && data['details'] != null && data['details'] is List) {
           final licenses = (data['details'] as List)
              .map((item) => DrivingLicenseModel.fromJson(item as Map<String, dynamic>))
              .toList();
           return ApiResult.success(licenses);
        }
        return ApiResult.failure(data['message']?.toString() ?? 'حدث خطأ في استرجاع الرخص.');
      }

      if (data is List) {
        final licenses = data
            .map((item) => DrivingLicenseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return ApiResult.success(licenses);
      }
      
      return ApiResult.success([]);
    } on DioException catch (e) {
      ApiErrorHandler.logError('GetMyLicenses', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  // --- Local Storage ---
  static const String _storageKey = 'cached_driving_licenses';

  Future<void> saveLicensesLocal(List<DrivingLicenseModel> licenses) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(licenses.map((l) => l.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<List<DrivingLicenseModel>> getLocalLicenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(_storageKey);
    if (encoded == null || encoded.isEmpty) return [];
    
    try {
      final List<dynamic> decoded = jsonDecode(encoded);
      return decoded
          .map((item) => DrivingLicenseModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
