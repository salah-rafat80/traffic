import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';
import '../../domain/entities/order_model.dart';

class ServiceRequestsRepository {
  final ApiClient _apiClient;

  ServiceRequestsRepository(this._apiClient);

  /// Fetches the authenticated citizen's service requests.
  /// Endpoint: GET /ServiceRequests/my-requests
  Future<ApiResult<List<OrderModel>>> fetchMyRequests() async {
    try {
      final response = await _apiClient.dio.get('/servicerequests/my-requests');
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (!isSuccess) {
          return ApiResult.failure(data['message']?.toString() ?? 'فشلت العملية');
        }

        final details = data['details'];
        if (details is List) {
          final items = details
              .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return ApiResult.success(items);
        }
      }

      // Fallback for direct List response
      if (data is List) {
        final items = data
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return ApiResult.success(items);
      }

      return ApiResult.failure('لم يتم استلام بيانات صحيحة');
    } on DioException catch (e) {
      ApiErrorHandler.logError('FetchMyRequests', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Fetches details for a single service request.
  /// Endpoint: GET /servicerequests/{requestNumber}
  ///
  /// NOTE: Not yet wired to the UI — response payload pending confirmation.
  Future<ApiResult<Map<String, dynamic>>> fetchRequestDetails(
    String requestNumber,
  ) async {
    try {
      final response = await _apiClient.dio.get(
        '/servicerequests/$requestNumber',
      );
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final isSuccess = data['isSuccess'] as bool? ?? false;
        if (!isSuccess) {
          return ApiResult.failure(data['message']?.toString() ?? 'فشلت العملية');
        }

        final details = data['details'];
        if (details is Map<String, dynamic>) {
          return ApiResult.success(details);
        }
        
        // Return whole map if no specific details field is found but it's successful
        return ApiResult.success(data);
      }

      return ApiResult.failure('لم يتم استلام بيانات التفاصيل');
    } on DioException catch (e) {
      ApiErrorHandler.logError('FetchRequestDetails', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }
}
