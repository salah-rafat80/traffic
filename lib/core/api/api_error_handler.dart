import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Centralized API error extraction — returns Arabic user-facing messages.
class ApiErrorHandler {
  /// Extracts a user-facing error message from a [DioException].
  static String extractMessage(DioException e, {String? fallback}) {
    if (e.response?.data != null) {
      final errorData = e.response!.data;

      if (errorData is Map<String, dynamic>) {
        // Shape: {"message": "..."}
        if (errorData['message'] != null) {
          return errorData['message'].toString();
        }
        // Shape: {"errors": {"field": ["error1", "error2"]}}
        if (errorData['errors'] != null && errorData['errors'] is Map) {
          final errors = errorData['errors'] as Map;
          final msgs = <String>[];
          for (final entry in errors.entries) {
            if (entry.value is List) {
              for (final msg in entry.value as List) {
                msgs.add(msg.toString());
              }
            }
          }
          if (msgs.isNotEmpty) return msgs.join('\n');
        }
        // Shape: {"detail": "..."}
        if (errorData['detail'] != null) {
          return errorData['detail'].toString();
        }
        // Shape: {"title": "..."}
        if (errorData['title'] != null) {
          return errorData['title'].toString();
        }
      }

      if (errorData is List) {
        return errorData.map((e) => e.toString()).join('\n');
      }

      if (errorData is String && errorData.isNotEmpty) {
        return errorData;
      }
    }

    return fallback ??
        'فشل العملية. (${e.response?.statusCode ?? 'no status'})';
  }

  /// Logs the error in debug mode.
  static void logError(String tag, DioException e) {
    debugPrint('$tag error: ${e.response?.statusCode}');
    debugPrint('$tag body: ${e.response?.data}');
  }
}
