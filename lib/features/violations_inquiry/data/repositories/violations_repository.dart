import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';
import 'package:injectable/injectable.dart';
import '../models/violation_model.dart';

@lazySingleton
class ViolationsRepository {
  final ApiClient _apiClient;

  ViolationsRepository(this._apiClient);

  /// Fetches driving license violations.
  ///
  /// Endpoint: GET /TrafficViolations/driving-license/{licenseNumber}
  Future<ApiResult<ViolationsListModel>> getDrivingLicenseViolations({
    required String licenseNumber,
  }) async {
    return _fetchViolations(endpoint: '/TrafficViolations/driving-license/$licenseNumber');
  }

  /// Fetches vehicle license violations.
  ///
  /// Endpoint: GET /TrafficViolations/vehicle-license/{licenseNumber}
  Future<ApiResult<ViolationsListModel>> getVehicleLicenseViolations({
    required String licenseNumber,
  }) async {
    return _fetchViolations(endpoint: '/TrafficViolations/vehicle-license/$licenseNumber');
  }

  Future<ApiResult<ViolationsListModel>> _fetchViolations({
    required String endpoint,
  }) async {
    try {
      final response = await _apiClient.dio.get(endpoint);

      final data = response.data;
      if (data is Map<String, dynamic>) {
        // Some endpoints wrap the response in 'details', some don't.
        // Looking at the collectionV2.json, the response looks like:
        // { "violations": [...], "totalCount": 2, "unpaidCount": 2, ... }
        // Or for Vehicle: { "isSuccess": true, "details": { "violations": [...], ... } }
        
        final isSuccess = data['isSuccess'] as bool? ?? true; // If missing, assume success (Driving API example doesn't have isSuccess at root)
        
        if (isSuccess) {
          final payload = data.containsKey('details') ? data['details'] : data;
          if (payload is Map<String, dynamic>) {
            return ApiResult.success(
              ViolationsListModel.fromJson(payload),
            );
          }
        }
        return ApiResult.failure(
          data['message']?.toString() ?? data['messageAr']?.toString() ?? 'فشل في استرجاع المخالفات.',
        );
      }

      return ApiResult.failure('استجابة غير متوقعة من الخادم.');
    } on DioException catch (e) {
      ApiErrorHandler.logError('GetViolations', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }
}
