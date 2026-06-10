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

## Reference Source

**Primary**: `Api/Morourak.postman_collection.json` — always use this as source of truth.

---

# Phase 2 — Integration (Cubit Scaffold)

> **Trigger**: User explicitly says _"Let's start integrating [feature name]"_

## Base URL & Shared Config

```
http://morourak.runasp.net/api/v1
```

Every repository MUST use the shared `ApiClient` instead of creating their own `Dio` instance.

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
    final publicPaths = [
      '/Auth/register',
      '/Auth/verify-otp',
      '/Auth/login',
      '/Auth/forgot-password',
      '/Auth/reset-password',
      '/VehicleTypes',
      '/appointments/available-slots',
      '/governorates',
      '/VehicleLicense/insurance-companies',
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

---

## Step 1 — Repository Template

**File**: `lib/features/<feature>/data/repositories/<feature>_repository.dart`

### JSON endpoint (GET/POST)

```dart
import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_error_handler.dart';
import '../../../../core/api/api_result.dart';

class FeatureRepository {
  final ApiClient _apiClient;
  FeatureRepository(this._apiClient);

  Future<ApiResult<ResponseModel>> submitAction({required String param}) async {
    try {
      final response = await _apiClient.dio.post(
        '/Endpoint/path',
        data: {'param': param},
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

### File upload (multipart/form-data)

```dart
Future<ApiResult<String>> uploadDocuments({
  required String category,
  required String personalPhotoPath,
  required String educationalCertificatePath,
  required String idCardPath,
  String? residenceProofPath,
  String? medicalCertificatePath,
}) async {
  try {
    final map = <String, dynamic>{
      'category': category,
      'personalPhoto': await MultipartFile.fromFile(personalPhotoPath),
      'educationalCertificate': await MultipartFile.fromFile(educationalCertificatePath),
      'idCard': await MultipartFile.fromFile(idCardPath),
    };
    if (residenceProofPath != null) {
      map['residenceProof'] = await MultipartFile.fromFile(residenceProofPath);
    }
    if (medicalCertificatePath != null) {
      map['medicalCertificate'] = await MultipartFile.fromFile(medicalCertificatePath);
    }

    final response = await _apiClient.dio.post(
      '/DrivingLicense/upload-documents',
      data: FormData.fromMap(map),
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data;
    if (data is Map<String, dynamic> && data['details']?['requestNumber'] != null) {
      return ApiResult.success(data['details']['requestNumber'].toString());
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

```dart
abstract class FeatureState {}
class FeatureInitial extends FeatureState {}
class FeatureLoading extends FeatureState {}
class FeatureSubmitSuccess extends FeatureState {
  final String? requestNumber;
  FeatureSubmitSuccess({this.requestNumber});
}
class FeatureFailure extends FeatureState {
  final String message;
  FeatureFailure({required this.message});
}
```

---

## Step 3 — Cubit

```dart
class FeatureCubit extends Cubit<FeatureState> {
  final FeatureRepository _repository;
  FeatureCubit(this._repository) : super(FeatureInitial());

  Future<void> submitAction({required String param}) async {
    emit(FeatureLoading());
    final result = await _repository.submitAction(param: param);
    if (result.isSuccess) {
      emit(FeatureSubmitSuccess(requestNumber: result.data?.requestNumber));
    } else {
      emit(FeatureFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }
}
```

---

# API Reference (Morourak.postman_collection.json — Updated)

## Base URL
```
http://morourak.runasp.net/api/v1
```

## Authentication
- **Bearer Token** required for most endpoints
- Token obtained from `POST /Auth/login`
- Stored in `SharedPreferences` key: `'token'`
- **Public endpoints** (no auth): Register, Verify OTP, Login, Forgot Password, Reset Password, Get Vehicle Types, Get Available Slots, Get Governorates, Get Insurance Companies

## Roles
| Role | Description |
|------|-------------|
| `CITIZEN` | Apply for services, book appointments, make payments |
| `STAFF / DOCTOR / INSPECTOR / EXAMINATOR` | Manage examination results |
| `ADMIN` | Manage users and seed data |

---

## 1. Authentication

| Method | Path | Purpose | Body | Auth |
|--------|------|---------|------|------|
| POST | `/Auth/register` | Create account | JSON | Public |
| POST | `/Auth/verify-otp` | Verify OTP | JSON | Public |
| POST | `/Auth/login` | Login → token | JSON | Public |
| GET | `/auth/profile` | View Profile | — | 🔒 Yes |
| POST | `/Auth/forgot-password` | Request reset | JSON | Public |
| POST | `/Auth/reset-password` | Set new password | JSON | Public |
| POST | `/auth/change-email/request` | Request email change | JSON | 🔒 Yes |
| POST | `/auth/change-email/confirm` | Confirm email change | JSON | 🔒 Yes |

### Register Body
```json
{
  "nationalId": "29801012345678",
  "mobileNumber": "01012345678",
  "firstName": "أحمد",
  "lastName": "علي",
  "Email": "user@example.com",
  "username": "ahmed",
  "password": "Password123!",
  "confirmPassword": "Password123!"
}
```

---

## 2. Driving License (🔒 CITIZEN)

### 2a. Issuance (First Time)

**Upload Documents** — `POST /DrivingLicense/upload-documents`
- **Content-Type**: `multipart/form-data`

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `category` | text (int enum) | ✅ | e.g. `1` |
| `personalPhoto` | file | ✅ | |
| `educationalCertificate` | file | ✅ | |
| `idCard` | file | ✅ | |
| `residenceProof` | file | ❌ | Optional |
| `medicalCertificate` | file | ❌ | If uploaded → skips medical appointment |

**Finalize License** — `POST /DrivingLicense/finalize/{requestNumber}`
- **Content-Type**: `application/json`
- `method`: `1` (TrafficUnit), `2` (HomeDelivery)

---

### 2b. Renewal

**Renewal-Request** — `POST /DrivingLicense/renewal-request`
- **Content-Type**: `multipart/form-data`
- Body: `LicenseNumber` (String), `NewCategory` (String, Optional)

**Finalize-Renewal** — `POST /DrivingLicense/finalize-renewal/{requestNumber}`
- **Content-Type**: `application/json`
- `method`: `1` (TrafficUnit), `2` (HomeDelivery)

---

### 2c. Replacement

**Issue-Replacement** — `POST /DrivingLicense/issue-replacement/{licenseNumber}`
- **Content-Type**: `application/json`
- Body: `replacementtype` ("Lost", "Damaged"), `delivery` { `method` (1, 2), `address` }

---

### 2d. Management

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/DrivingLicense/my-licenses` | Get citizen's licenses |

---

## 3. Vehicle License (🔒 CITIZEN)

### 3a. Issuance

**Upload Initial Documents** — `POST /VehicleLicense/upload-documents`
- **Content-Type**: `multipart/form-data`
- `VehicleType`: 0=Private, 1=Truck, 2=Taxi, 3=Motorcycle, 4=Bus, 5=PrivateBus, 6=Trailer
- `InsuranceCompanyId`: Fetch from `/insurance-companies`

**Finalize License** — `POST /VehicleLicense/finalize/{requestNumber}`
- `method`: `1` (TrafficUnit), `2` (HomeDelivery)

---

### 3b. Renewal

**Renew** — `POST /VehicleLicense/renew`
- Body: `VehicleLicenseNumber` (form-data)

**Finalize Renewal** — `POST /VehicleLicense/finalize-renewal/{requestNumber}`

---

### 3c. Replacement

**Replace lost/damaged** — `POST /VehicleLicense/issue-replacement/{licenseNumber}`
- `replacementtype`: "بدل فاقد" (0), "بدل تالف" (1)
- `delivery.method`: "وحدة المرور" (1), "توصيل للمنزل" (2)

---

### 3d. Management

| Method | Path | Auth | Purpose |
|--------|------|------|---------|
| GET | `/VehicleTypes` | Public | Get vehicle types + brands + models |
| GET | `/VehicleLicense/my-licenses` | 🔒 | Citizen's vehicle licenses |
| GET | `/VehicleLicense/insurance-companies` | Public | Insurance companies list |

---

## 4. Traffic Violations (🔒 CITIZEN)

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/TrafficViolations/driving-license/{licenseNumber}` | Violations for driving license |
| GET | `/TrafficViolations/vehicle-license/{licenseNumber}` | Violations for vehicle license |
| GET | `/TrafficViolations/license/{licenseNumber}/details?licenseType=Driving|Vehicle` | Detailed violations |

---

## 5. Appointments & Locations

### Lookups (Public)

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/governorates` | All governorates |
| GET | `/governorates/{id}/traffic-units` | Traffic units by governorate |

### Booking Flow

**Get Available Slots** — `GET /appointments/available-slots?date=YYYY-MM-DD&type=Medical`
- `type`: Medical, Technical, Driving

**Book Appointment** — `POST /appointments/book` (🔒 CITIZEN)
- `requestNumber` (Optional): specific request to link to
- `appointmentType` (int) or `serviceType` (string Arabic/English)

---

## 6. Payments (🔒 CITIZEN)

**Create Payment** — `POST /payment/create`
- `ServiceRequestNumber` OR `violationIds`

**Payment Status** — `GET /Payment/status/{merchantOrderId}`

**Get Receipt** — `GET /Payment/receipt/{merchantOrderId}`

---

## 7. Service Requests (🔒 CITIZEN)

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/servicerequests/my-requests` | All my requests |
| GET | `/service-requests/{requestNumber}` | Request details |

---

## 8. Staff (🔒 STAFF roles)

| Method | Path | Role | Purpose |
|--------|------|------|---------|
| GET | `/Staff` | DOCTOR/INSPECTOR/EXAMINATOR | Get assigned appointments |
| POST | `/Staff/submit` | DOCTOR/INSPECTOR/EXAMINATOR | Submit examination result |

---

## 9. Admin (🔒 ADMIN)

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/AdminSeedData/citizens` | Get citizens |
| GET | `/AdminSeedData/vehicle-licenses` | Get vehicle licenses |
| GET | `/AdminSeedData/driving-licenses` | Get driving licenses |
| GET | `/adminusers` | List users |
| POST | `/adminusers` | Create user |
| PUT | `/adminusers/{id}` | Update user |
| DELETE | `/adminusers/{id}` | Delete user |

---

## Delivery Method Values

| Value | Meaning | Address Required? |
|-------|---------|-------------------|
| `1` | TrafficUnit (وحدة المرور) | ❌ No |
| `2` | HomeDelivery (توصيل منزلي) | ✅ Yes |

---

## Flow Dependencies

```
Driving License Issuance:
  upload-documents → requestNumber (LR-XXXXXX)
    └─ finalize/{requestNumber} → full license

Driving License Renewal:
  renewal-request (form-data: LicenseNumber) → requestNumber (DR-XXX)
    └─ finalize-renewal/{requestNumber} → updated license

Vehicle License Issuance:
  upload-documents → requestNumber (REQ-VL-XXXX)
    └─ finalize/{requestNumber} → license issued

Vehicle License Renewal:
  renew (form-data: VehicleLicenseNumber) → requestNumber (VR-XXXX)
    └─ finalize-renewal/{requestNumber} → renewed

Payment:
  payment/create (ServiceRequestNumber or violationIds)
    → merchantOrderId (MOR-...) + paymentUrl
      └─ Payment/status/{merchantOrderId} → status
        └─ Payment/receipt/{merchantOrderId} → receipt
```

---

## Important Notes

1. **Token storage**: `SharedPreferences` key `'token'`
2. **Public endpoints**: Register, Verify OTP, Login, Forgot Password, Reset Password, Get Vehicle Types, Get Available Slots, Get Governorates, Get Insurance Companies
3. **XOR Logic**: `medicalCertificate` upload skips medical appointment.
4. **Replacement APIs**: Use `/DrivingLicense/issue-replacement/{licenseNumber}` and `/VehicleLicense/issue-replacement/{licenseNumber}`.
5. **Vehicle License Renewal**: Requires `VehicleLicenseNumber` in form-data.
6. **Appointments**: Booking supports optional `requestNumber` linking.
7. **Payments**: Supports both service requests and violation payments.
8. **Driving License Issuance**: `educationalCertificate` is now **mandatory** for first-time issuance.
9. **Response Structure**: Most successful requests return a wrapper with `{ "isSuccess": true, "details": { ... } }`. Always check `details` for the actual payload.

---

## Integration Checklist

- [ ] Verify `lib/core/api/api_client.dart` exists (public paths updated)
- [ ] Verify `lib/core/api/api_error_handler.dart` exists
- [ ] Verify `lib/core/api/api_result.dart` exists
- [ ] `lib/features/<feature>/data/models/<model>_model.dart` — with `fromJson`/`toJson`
- [ ] `lib/features/<feature>/data/repositories/<feature>_repository.dart`
- [ ] `lib/features/<feature>/presentation/cubits/<feature>_state.dart`
- [ ] `lib/features/<feature>/presentation/cubits/<feature>_cubit.dart`
- [ ] Wire `BlocProvider` in the screen
- [ ] Add `BlocConsumer` in the feature screen
- [ ] Validate with `flutter analyze`
- [ ] Test the flow end-to-end
