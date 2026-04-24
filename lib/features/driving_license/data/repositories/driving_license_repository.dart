import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';
import '../models/driving_license_model.dart';
import '../models/driving_license_finalize_model.dart';
import '../models/issue_replacement_response_model.dart';
import '../../../../core/api/request_id_manager.dart';

class DrivingLicenseRepository {
  final ApiClient _apiClient;

  DrivingLicenseRepository(this._apiClient);

  /// Requests the issuance of a replacement for a driving license.
  Future<ApiResult<IssueReplacementResponseModel>> issueReplacement({
    required String licenseNumber,
    required String replacementType,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'replacementtype': replacementType,
        'delivery': <String, dynamic>{
          'method': method,
        }
      };

      if (method == 2) {
        (body['delivery'] as Map<String, dynamic>)['address'] = {
          'governorate': governorate,
          'city': city,
          'details': details,
        };
      }

      final response = await _apiClient.dio.post(
        '/DrivingLicense/issue-replacement/$licenseNumber',
        data: body,
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess && data['details'] != null && data['details'] is Map) {
          return ApiResult.success(IssueReplacementResponseModel.fromJson(data['details'] as Map<String, dynamic>));
        } else if (isSuccess) {
          return ApiResult.success(IssueReplacementResponseModel.fromJson(data));
        }
        
        // Handle fallback if data isn't wrapped
        if (!data.containsKey('isSuccess')) {
          return ApiResult.success(IssueReplacementResponseModel.fromJson(data));
        }
        
        return ApiResult.failure(data['message']?.toString() ?? 'لم يتم استلام تفاصيل طلب بدل الفاقد/التالف.');
      }

      return ApiResult.failure('استجابة غير متوقعة من الخادم.');
    } on DioException catch (e) {
      ApiErrorHandler.logError('IssueReplacement', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Uploads documents for First-Time Driving License Issuance using multipart/form-data.
  /// Note: governorate and licensingUnit are no longer part of this request per API v2.
  /// The citizen selects location during appointment booking instead.
  Future<ApiResult<String>> uploadDocuments({
    required String category,
    required String personalPhotoPath,
    required String idCardPath,
    required String educationalCertificatePath,
    String? residenceProofPath,
    String? medicalCertificatePath,
  }) async {
    try {
      final Map<String, dynamic> dataMap = {
        'category': category,
        'personalPhoto': await MultipartFile.fromFile(personalPhotoPath),
        'idCard': await MultipartFile.fromFile(idCardPath),
        'educationalCertificate': await MultipartFile.fromFile(educationalCertificatePath),
      };

      if (residenceProofPath != null) {
        dataMap['residenceProof'] = await MultipartFile.fromFile(residenceProofPath);
      }
      if (medicalCertificatePath != null) {
        // Uploading medical certificate skips the medical appointment booking step.
        dataMap['medicalCertificate'] = await MultipartFile.fromFile(medicalCertificatePath);
      }

      final formData = FormData.fromMap(dataMap);

      final response = await _apiClient.dio.post(
        '/DrivingLicense/upload-documents',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final extractedId = RequestIdManager().extractId(data);
        if (extractedId != null) {
          RequestIdManager().updateRequestId(extractedId);
          return ApiResult.success(extractedId);
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
  /// method: 1 = TrafficUnit pickup (no address), 2 = HomeDelivery (address required).
  Future<ApiResult<DrivingLicenseFinalizeResponseModel>> finalizeDrivingLicense({
    required String requestNumber,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    try {
      final Map<String, dynamic> body = <String, dynamic>{
        'method': method,
      };

      if (method == 2) {
        body['address'] = <String, dynamic>{
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
        final bool isSuccess = data['isSuccess'] as bool? ?? false;

        if (isSuccess) {
          final extractedId = RequestIdManager().extractId(data);
          if (extractedId != null) {
            RequestIdManager().updateRequestId(extractedId);
          }
          
          final Object? rawDetails = data['details'];
          if (rawDetails is Map<String, dynamic>) {
            return ApiResult.success(
              DrivingLicenseFinalizeResponseModel.fromJson(
                rawDetails as Map<String, Object?>,
              ),
            );
          }
        }

        return ApiResult.failure(
          data['message']?.toString() ?? 'فشل استكمال طلب إصدار الرخصة.',
        );
      }

      return ApiResult.failure('استجابة غير متوقعة من الخادم.');
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
