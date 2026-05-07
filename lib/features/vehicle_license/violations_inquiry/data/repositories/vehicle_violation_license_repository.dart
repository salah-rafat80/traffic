import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/api_error_handler.dart';
import '../../../../../../core/api/api_result.dart';
import '../models/vehicle_license_violation_model.dart';

/// Repository for fetching the citizen's vehicle licenses,
/// used by the violations-inquiry sub-feature.
///
/// Endpoint: GET /VehicleLicense/my-licenses
@lazySingleton
class VehicleViolationLicenseRepository {
  final ApiClient _apiClient;

  VehicleViolationLicenseRepository(this._apiClient);

  static const String _storageKey = 'cached_vehicle_violation_licenses';

  /// Fetches vehicle licenses from the API.
  Future<ApiResult<List<VehicleLicenseViolationModel>>> getMyLicenses() async {
    try {
      final response = await _apiClient.dio.get('/VehicleLicense/my-licenses');
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (isSuccess && data['details'] is List) {
          final licenses = (data['details'] as List)
              .map((item) => VehicleLicenseViolationModel.fromJson(
                    item as Map<String, dynamic>,
                  ))
              .toList();
          return ApiResult.success(licenses);
        }
        return ApiResult.failure(
          data['message']?.toString() ?? 'حدث خطأ في استرجاع رخص المركبات.',
        );
      }

      if (data is List) {
        final licenses = data
            .map((item) => VehicleLicenseViolationModel.fromJson(
                  item as Map<String, dynamic>,
                ))
            .toList();
        return ApiResult.success(licenses);
      }

      return ApiResult.success([]);
    } on DioException catch (e) {
      ApiErrorHandler.logError('GetMyVehicleViolationLicenses', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Saves the license list to SharedPreferences cache.
  Future<void> saveLicensesLocal(
    List<VehicleLicenseViolationModel> licenses,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(licenses.map((l) => l.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  /// Loads the cached license list from SharedPreferences.
  Future<List<VehicleLicenseViolationModel>> getLocalLicenses() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_storageKey);
    if (encoded == null || encoded.isEmpty) return [];
    try {
      final decoded = jsonDecode(encoded) as List;
      return decoded
          .map((item) => VehicleLicenseViolationModel.fromJson(
                item as Map<String, dynamic>,
              ))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
