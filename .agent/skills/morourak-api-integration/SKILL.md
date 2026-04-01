---
name: Morourak API Integration (Cubit-Based)
description: Two-phase workflow for Morourak API integration — Phase 1 studies the API docs without code changes; Phase 2 scaffolds Cubit + Repository + State for each feature using a fixed, scalable pattern. Project-specific to the Morourak traffic-services Flutter app.
---

# Morourak API Integration Skill

## Overview

This skill defines the **only** way API features are integrated into the Morourak Flutter app.
It operates in **two phases**:

| Phase | Name | Trigger | Code Changes? |
|-------|------|---------|---------------|
| 1 | **Study & Understanding** | Default (active until user says otherwise) | ❌ None |
| 2 | **Integration** | User says: _"Let's start integrating [feature name]"_ | ✅ Yes — Cubit scaffold only |

---

# Phase 1 — Study & Understanding

## Rules (STRICT)

- ❌ Do NOT suggest any code changes
- ❌ Do NOT refactor or modify existing code
- ❌ Do NOT assume anything not stated in the API docs
- ✅ Only answer questions about the API
- ✅ If asked about an endpoint, give exact field names, types, and structure
- ✅ If you notice something unclear in the docs, flag it as a ⚠️ question

## What You Must Understand

| Aspect | Check |
|--------|-------|
| Every endpoint | method, full URL, purpose |
| Request structure | body (JSON or form-data), URL params, query params |
| Authentication | which endpoints require Bearer Token, which don't |
| Response shapes | fields, types, nesting |
| Flow dependencies | upload → requestNumber → finalize chains |
| File uploads | multipart/form-data vs JSON |

## Reference Sources

1. **Primary**: `morourak_api_docs.md` (root of project)
2. **Detailed**: `Morourak.postman_collection.json` (includes response examples, field descriptions)
3. **Existing code**: `lib/features/auth/data/repositories/auth_repository.dart` (reference implementation)

---

# Phase 2 — Integration (Cubit Scaffold)

> **Trigger**: User explicitly says _"Let's start integrating [feature name]"_

## Base URL & Shared Config

```
http://morourak.runasp.net/api/v1
```

Every repository MUST use the shared `ApiClient` (below) instead of creating their own `Dio` instance.

---

## Step 0 — Core API Infrastructure (create once)

### `lib/core/api/api_client.dart`

```dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String baseUrl = 'http://morourak.runasp.net/api/v1';

  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    ));
    dio.interceptors.add(_AuthInterceptor());
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for public endpoints
    final publicPaths = [
      '/Auth/register',
      '/Auth/verify-otp',
      '/Auth/login',
      '/Auth/forgot-password',
      '/Auth/reset-password',
      '/VehicleTypes',
      '/appointments/available-slots',
    ];

    final isPublic = publicPaths.any(
      (path) => options.path.contains(path),
    );

    if (!isPublic) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }
}
```

### `lib/core/api/api_error_handler.dart`

```dart
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
```

### `lib/core/api/api_result.dart`

```dart
/// Generic result wrapper for API calls.
/// 
/// Use [ApiResult.success] when the call succeeds, passing the data.
/// Use [ApiResult.failure] when it fails, passing the error message.
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const ApiResult._({this.data, this.error, required this.isSuccess});

  factory ApiResult.success([T? data]) =>
      ApiResult._(data: data, isSuccess: true);

  factory ApiResult.failure(String error) =>
      ApiResult._(error: error, isSuccess: false);
}
```

---

## Step 1 — Repository (Data Layer)

**File**: `lib/features/<feature>/data/repositories/<feature>_repository.dart`

### Template — JSON endpoint (GET/POST)

```dart
import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';

class FeatureRepository {
  final ApiClient _apiClient;

  FeatureRepository(this._apiClient);

  /// Fetches data from the API.
  /// Returns [ApiResult.success] with data on success,
  /// [ApiResult.failure] with Arabic error message on failure.
  Future<ApiResult<List<FeatureModel>>> fetchItems() async {
    try {
      final response = await _apiClient.dio.get('/Endpoint/path');
      final data = response.data;
      
      if (data is List) {
        final items = data
            .map((json) => FeatureModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return ApiResult.success(items);
      }
      
      return ApiResult.failure('لم يتم استلام بيانات صحيحة');
    } on DioException catch (e) {
      ApiErrorHandler.logError('FetchItems', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }

  /// Submits data to the API (POST with JSON body).
  Future<ApiResult<ResponseModel>> submitAction({
    required String param1,
    required String param2,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/Endpoint/path',
        data: {
          'param1': param1,
          'param2': param2,
        },
      );
      
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ApiResult.success(ResponseModel.fromJson(data));
      }
      
      return ApiResult.success();
    } on DioException catch (e) {
      ApiErrorHandler.logError('SubmitAction', e);
      return ApiResult.failure(ApiErrorHandler.extractMessage(e));
    } catch (e) {
      return ApiResult.failure('حدث خطأ غير متوقع.');
    }
  }
}
```

### Template — File upload (multipart/form-data)

```dart
/// Uploads documents using multipart/form-data.
Future<ApiResult<String>> uploadDocuments({
  required String category,
  required String governorate,
  required String licensingUnit,
  required String personalPhotoPath,
  required String idCardPath,
}) async {
  try {
    final formData = FormData.fromMap({
      'category': category,
      'governorate': governorate,
      'licensingUnit': licensingUnit,
      'personalPhoto': await MultipartFile.fromFile(personalPhotoPath),
      'idCard': await MultipartFile.fromFile(idCardPath),
    });

    final response = await _apiClient.dio.post(
      '/Endpoint/upload-documents',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data;
    if (data is Map<String, dynamic> && data['requestNumber'] != null) {
      return ApiResult.success(data['requestNumber'].toString());
    }

    return ApiResult.failure('لم يتم استلام رقم الطلب');
  } on DioException catch (e) {
    ApiErrorHandler.logError('UploadDocuments', e);
    return ApiResult.failure(ApiErrorHandler.extractMessage(e));
  } catch (e) {
    return ApiResult.failure('حدث خطأ غير متوقع.');
  }
}
```

---

## Step 2 — State Classes

**File**: `lib/features/<feature>/presentation/cubits/<feature>_state.dart`

```dart
abstract class FeatureState {}

class FeatureInitial extends FeatureState {}

class FeatureLoading extends FeatureState {}

/// Use one success state per distinct action in the cubit.
/// Include response data as fields when the UI needs it.
class FeatureFetchSuccess extends FeatureState {
  final List<FeatureModel> items;
  FeatureFetchSuccess({required this.items});
}

class FeatureSubmitSuccess extends FeatureState {
  final String? requestNumber; // optional — for chained flows
  FeatureSubmitSuccess({this.requestNumber});
}

class FeatureFailure extends FeatureState {
  final String message;
  FeatureFailure({required this.message});
}
```

### Naming Convention

| State | When |
|-------|------|
| `<Feature>Initial` | Before any action |
| `<Feature>Loading` | During API call |
| `<Feature><Action>Success` | Action specific success (e.g., `DrivingLicenseUploadSuccess`) |
| `<Feature>Failure` | Any failure — carries `message` |

---

## Step 3 — Cubit

**File**: `lib/features/<feature>/presentation/cubits/<feature>_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/feature_repository.dart';
import 'feature_state.dart';

class FeatureCubit extends Cubit<FeatureState> {
  final FeatureRepository _repository;

  FeatureCubit(this._repository) : super(FeatureInitial());

  Future<void> fetchItems() async {
    emit(FeatureLoading());
    final result = await _repository.fetchItems();
    if (result.isSuccess) {
      emit(FeatureFetchSuccess(items: result.data ?? []));
    } else {
      emit(FeatureFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> submitAction({
    required String param1,
    required String param2,
  }) async {
    emit(FeatureLoading());
    final result = await _repository.submitAction(
      param1: param1,
      param2: param2,
    );
    if (result.isSuccess) {
      emit(FeatureSubmitSuccess(requestNumber: result.data?.requestNumber));
    } else {
      emit(FeatureFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }
}
```

### Cubit Rules
1. The cubit does **not** call Dio directly — it delegates to the Repository.
2. The cubit does **not** handle navigation — that belongs in `BlocListener` in the UI.
3. Each public method follows: `emit(Loading) → call repo → emit(Success | Failure)`.
4. Use `ApiResult` from the repository — no more `String?` null-means-success pattern.

---

## Step 4 — Screen Wiring

```dart
// In the screen that triggers the feature:
import 'package:flutter_bloc/flutter_bloc.dart';

// Provide the Cubit at the screen level
BlocProvider(
  create: (_) => FeatureCubit(
    FeatureRepository(ApiClient()),
  ),
  child: const FeatureScreen(),
)

// Inside FeatureScreen build():
BlocConsumer<FeatureCubit, FeatureState>(
  listener: (context, state) {
    if (state is FeatureSubmitSuccess) {
      // Navigate forward
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NextScreen()),
      );
    } else if (state is FeatureFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    if (state is FeatureLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is FeatureFetchSuccess) {
      return ListView.builder(
        itemCount: state.items.length,
        itemBuilder: (_, i) => FeatureCard(item: state.items[i]),
      );
    }
    return const SizedBox.shrink();
  },
)
```

---

## Step 5 — Model (Data Layer)

**File**: `lib/features/<feature>/data/models/<model>_model.dart`

```dart
class FeatureModel {
  final int id;
  final String name;
  final String status;

  const FeatureModel({
    required this.id,
    required this.name,
    required this.status,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }

  /// Keep dummy data for local dev fallback
  static List<FeatureModel> get dummyItems => const [
    FeatureModel(id: 1, name: 'عنصر تجريبي', status: 'نشط'),
  ];
}
```

---

# API Reference (Embedded)

## Base URL
```
http://morourak.runasp.net/api/v1
```

## Authentication
- **Bearer Token** required for most endpoints
- Token obtained from `POST /Auth/login` response
- Store in `SharedPreferences` key: `'token'`
- **Public endpoints** (no auth): Register, Verify OTP, Login, Forgot Password, Reset Password, Get Vehicle Types, Get Available Slots

## Endpoint Catalog

### 1. Auth (Public — no token needed)

| Method | Path | Purpose | Body Type |
|--------|------|---------|-----------|
| POST | `/Auth/register` | Create account | JSON |
| POST | `/Auth/verify-otp` | Verify OTP code | JSON |
| POST | `/Auth/login` | Login → token | JSON |
| POST | `/Auth/forgot-password` | Request reset code | JSON |
| POST | `/Auth/reset-password` | Set new password | JSON |

### 2. Driving License (🔒 Auth Required)

| Method | Path | Purpose | Body Type |
|--------|------|---------|-----------|
| POST | `/DrivingLicense/upload-documents` | First-time issuance docs | form-data (files) |
| POST | `/DrivingLicense/finalize/{requestNumber}` | Finalize issuance | JSON |
| POST | `/DrivingLicense/renewal-request` | Renew license | No body |
| POST | `/DrivingLicense/finalize-renewal/{requestNumber}` | Finalize renewal | JSON |
| POST | `/DrivingLicense/issue-replacement/{licenseNumber}` | Lost/damaged replacement | JSON |
| GET | `/DrivingLicense/my-licenses` | Get citizen's licenses | — |

### 3. Vehicle License (🔒 Auth Required)

| Method | Path | Purpose | Body Type |
|--------|------|---------|-----------|
| POST | `/VehicleLicense/upload-documents` | First-time issuance docs | form-data (files) |
| POST | `/VehicleLicense/finalize/{requestNumber}` | Finalize issuance | JSON |
| POST | `/VehicleLicense/renew` | Renew license | form-data |
| POST | `/VehicleLicense/finalize-renewal/{requestNumber}` | Finalize renewal | JSON |
| POST | `/VehicleLicense/replacement/{licenseNumber}?type=lost\|damaged` | Replacement | JSON |
| GET | `/VehicleLicense/my-licenses` | Get citizen's licenses | — |
| GET | `/VehicleTypes` | Get vehicle types (Public) | — |

### 4. Traffic Violations (🔒 Auth Required)

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/TrafficViolations/driving-license/{licenseNumber}` | Violations for driving license |
| GET | `/TrafficViolations/vehicle-license/{licenseNumber}` | Violations for vehicle license |
| GET | `/TrafficViolations/license/{licenseNumber}/details?licenseType=Driving\|Vehicle` | Detailed violations |

### 5. Appointments

| Method | Path | Purpose | Auth |
|--------|------|---------|------|
| POST | `/appointments/book` | Book appointment | 🔒 Yes |
| GET | `/appointments/available-slots?date=YYYY-MM-DD&type=Medical` | Available slots | Public |
| GET | `/appointments/my` | My appointments | 🔒 Yes |

### 6. Payments (🔒 Auth Required)

| Method | Path | Purpose |
|--------|------|---------|
| POST | `/payment/create` | Create payment (violationIds) |
| GET | `/Payment/status/{orderId}` | Payment status |
| GET | `/Payment/receipt/{orderId}` | Payment receipt |

### 7. Service Requests (🔒 Auth Required)

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/servicerequests/my-requests` | All my requests |
| GET | `/service-requests/{requestNumber}` | Request details |

## Flow Dependencies

```
┌─ upload-documents ─┐
│   Returns: requestNumber (e.g. "DL-500")
└────────┬───────────┘
         ▼
┌─ finalize/{requestNumber} ─┐
│   Returns: Full license data
└────────────────────────────┘

┌─ renewal-request ───────┐
│   Returns: requestNumber (e.g. "DR-800")
└────────┬────────────────┘
         ▼
┌─ finalize-renewal/{requestNumber} ─┐
│   Returns: Updated license data
└────────────────────────────────────┘

┌─ TrafficViolations ───┐
│   Returns: violationIds
└────────┬──────────────┘
         ▼
┌─ payment/create ──────┐
│   Body: { violationIds: [...] }
│   Returns: orderId (e.g. "MOR-...")
└────────┬──────────────┘
         ▼
┌─ Payment/status/{orderId} ─┐
│   Returns: payment status
└────────────────────────────┘
```

## Delivery Method Values

| Value | Meaning | Address Required? |
|-------|---------|-------------------|
| `1` | وحدة المرور (Traffic Unit pickup) | ❌ No |
| `2` | توصيل منزلي (Home Delivery) | ✅ Yes |

## Important Notes

1. **Token storage**: `SharedPreferences` with key `'token'`
2. **Form-data uploads**: `upload-documents` endpoints use `multipart/form-data`, not JSON
3. **Request numbers**: Returned by `upload-documents`, used in `finalize` — **must be passed between screens**
4. **Payment order IDs**: Start with `MOR-`, returned from backend
5. **Response language**: Some fields come in Arabic from the backend (status, category, citizenName)
6. **Renewal-request body**: The `DrivingLicense/renewal-request` has optional `NewCategory` field in form-data, **not JSON**

---

# Integration Checklist

When integrating a new feature, create these files in order:

- [ ] Verify `lib/core/api/api_client.dart` exists (create once)
- [ ] Verify `lib/core/api/api_error_handler.dart` exists (create once)
- [ ] Verify `lib/core/api/api_result.dart` exists (create once)
- [ ] `lib/features/<feature>/data/models/<model>_model.dart` — with `fromJson`/`toJson`
- [ ] `lib/features/<feature>/data/repositories/<feature>_repository.dart` — uses `ApiClient`
- [ ] `lib/features/<feature>/presentation/cubits/<feature>_state.dart`
- [ ] `lib/features/<feature>/presentation/cubits/<feature>_cubit.dart` — uses `ApiResult`
- [ ] Wire `BlocProvider` in the screen that navigates to this feature
- [ ] Add `BlocConsumer` in the feature screen
- [ ] Validate with `flutter analyze`
- [ ] Test the flow end-to-end
