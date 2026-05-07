import 'package:flutter/foundation.dart';

/// A singleton manager responsible for dynamically extracting and storing
/// Request IDs / Order Numbers from API responses.
class RequestIdManager {
  static final RequestIdManager _instance = RequestIdManager._internal();
  factory RequestIdManager() => _instance;
  RequestIdManager._internal();

  String? _currentRequestId;

  /// Returns the latest extracted Request ID.
  String? get currentRequestId => _currentRequestId;

  /// Updates the stored Request ID and logs it.
  void updateRequestId(String? id) {
    if (id != null && id.isNotEmpty) {
      _currentRequestId = id;
      debugPrint('--- RequestIdManager ---');
      debugPrint('Request created successfully');
      debugPrint('Extracted Request ID = $id');
      debugPrint('------------------------');
    }
  }

  /// Clears the stored Request ID (useful when a flow ends or is reset).
  void clearRequestId() {
    _currentRequestId = null;
    debugPrint('RequestIdManager: Request ID cleared.');
  }

  /// Smart parsing of response data to find request ID based on common backend keys.
  String? extractId(dynamic data) {
    if (data == null) return null;

    final List<String> potentialKeys = [
      'requestNumber',
      'serviceRequestNumber',
      'serviceNumber',
      'requestId',
      'orderId',
      'applicationId',
      'id',
    ];

    if (data is Map<String, dynamic>) {
      // 1. Check top level
      for (final key in potentialKeys) {
        if (data[key] != null) return data[key].toString();
      }

      // 2. Check 'details' wrapper (common in Morourak API)
      if (data['details'] != null && data['details'] is Map<String, dynamic>) {
        final details = data['details'] as Map<String, dynamic>;
        for (final key in potentialKeys) {
          if (details[key] != null) return details[key].toString();
        }
      }

      // 3. Check 'data' wrapper
      if (data['data'] != null && data['data'] is Map<String, dynamic>) {
        final innerData = data['data'] as Map<String, dynamic>;
        for (final key in potentialKeys) {
          if (innerData[key] != null) return innerData[key].toString();
        }
      }
    }
    return null;
  }
}
