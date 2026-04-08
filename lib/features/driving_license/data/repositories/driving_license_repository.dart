import 'package:dio/dio.dart';
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
        return ApiResult.success(DrivingLicenseModel.fromJson(data));
      }

      return ApiResult.failure('لم يتم استلام بيانات الرخصة النهائية');
    } on DioException catch (e) {
      ApiErrorHandler.logError('FinalizeDrivingLicense', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }
}
