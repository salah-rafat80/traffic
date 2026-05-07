import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/features/payment/models/payment_init_response.dart';
import 'package:traffic/core/api/request_id_manager.dart';
import 'package:flutter/foundation.dart';

@lazySingleton
class PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepository(this._apiClient);

  Future<PaymentInitResponse> createPayment({
    String? serviceRequestNumber,
    List<int>? violationIds,
    double? amount,
  }) async {
    try {
      final effectiveId = serviceRequestNumber ?? RequestIdManager().currentRequestId;

      if ((effectiveId == null || effectiveId.isEmpty) && (violationIds == null || violationIds.isEmpty)) {
        debugPrint('CreatePayment: FAILED - Service Request Number or Violation IDs missing.');
        throw Exception('رقم الطلب أو أرقام المخالفات مطلوبة لإتمام عملية الدفع.');
      }

      debugPrint('CreatePayment: Initiating payment (RequestId = $effectiveId, Violations = $violationIds, Amount = $amount)');

      final data = <String, dynamic>{};
      if (violationIds != null && violationIds.isNotEmpty) {
        data['violationIds'] = violationIds;
      } else if (effectiveId != null && effectiveId.isNotEmpty) {
        data['ServiceRequestNumber'] = effectiveId;
      }

      if (amount != null && amount > 0) {
        data['amount'] = amount;
      }

      final response = await _apiClient.dio.post(
        '/payment/create',
        data: data,
      );

      if (response.statusCode == 200) {
        // Handle wrapper or direct response
        final data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('details')) {
          return PaymentInitResponse.fromJson(data['details']);
        } else if (data is Map<String, dynamic>) {
          return PaymentInitResponse.fromJson(data);
        }
        throw Exception('Invalid payment response format');
      } else {
        throw Exception('Failed to create payment: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      String? message;
      if (data is Map<String, dynamic>) {
        message = data['message'] as String?;
      }
      message ??= e.message;
      throw Exception('Payment API Error: $message');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> checkPaymentStatus(String merchantOrderId) async {
    try {
      final response = await _apiClient.dio.get('/Payment/status/$merchantOrderId');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('details')) {
          final details = data['details'];
          if (details is Map<String, dynamic>) {
            return details['status'] as String? ?? 'Unknown';
          }
        } else if (data is Map<String, dynamic>) {
          return data['status'] as String? ?? 'Unknown';
        }
      }
      return 'Unknown';
    } catch (e) {
      return 'Error';
    }
  }
}
