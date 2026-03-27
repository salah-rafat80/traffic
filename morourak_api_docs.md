# Morourak API — Reference for AI Agent

## Base URL
```
http://morourak.runasp.net/api/v1
```

## Authentication
- معظم الـ endpoints بتحتاج **Bearer Token** في الـ header:
  ```
  Authorization: Bearer <token>
  ```
- الـ token بيتجاب من endpoint الـ Login
- الـ endpoints اللي مش محتاجة auth: Register, Verify OTP, Login, Forgot Password, Reset Password, Get Vehicle Types, Get Available Slots

---

## 1. Authentication

### POST /Auth/register
تسجيل مستخدم جديد

**Body (JSON):**
```json
{
  "nationalId": "29902012345678",
  "mobileNumber": "01198765432",
  "firstName": "عمر",
  "lastName": "أحمد",
  "Email": "user@example.com",
  "username": "omarr",
  "password": "Password123!",
  "confirmPassword": "Password123!"
}
```

---

### POST /Auth/verify-otp
التحقق من الـ OTP بعد التسجيل

**Body (JSON):**
```json
{
  "email": "user@example.com",
  "code": "839107"
}
```

---

### POST /Auth/login
تسجيل الدخول والحصول على الـ Token

**Body (JSON):**
```json
{
  "mobileNumber": "01198765432",
  "password": "Password123!"
}
```

**Response يحتوي على الـ Bearer Token**

---

### POST /Auth/forgot-password
طلب إعادة تعيين كلمة المرور

**Body (JSON):**
```json
{
  "email": "user@example.com"
}
```

---

### POST /Auth/reset-password
تعيين كلمة مرور جديدة

**Body (JSON):**
```json
{
  "email": "user@example.com",
  "code": "284668",
  "newPassword": "NewPass123!"
}
```

---

## 2. Driving License (رخصة القيادة)

### POST /DrivingLicense/upload-documents
🔒 Auth Required | رفع مستندات إصدار رخصة قيادة لأول مرة

**Body (form-data — يحتوي على ملفات):**
| Field | Type | Description |
|---|---|---|
| category | text | فئة الرخصة (مثال: 1) |
| governorate | text | المحافظة (مثال: القاهرة) |
| licensingUnit | text | وحدة الترخيص (مثال: مدينة نصر) |
| personalPhoto | file | صورة شخصية |
| educationalCertificate | file | شهادة تعليمية |
| idCard | file | بطاقة الهوية |
| residenceProof | file | إثبات الإقامة |

---

### POST /DrivingLicense/finalize/{requestNumber}
🔒 Auth Required | إتمام إصدار الرخصة وتحديد طريقة الاستلام

**URL Param:** `requestNumber` — مثال: `DL-500`

**Body (JSON):**
```json
{
  "method": 2,
  "address": {
    "governorate": "Cairo",
    "city": "Nasr City",
    "details": "123 Street Name, Building 5"
  }
}
```

**Response Example:**
```json
{
  "id": 21,
  "drivingLicenseNumber": "DL-100021",
  "category": "درجة أولى",
  "governorate": "القاهرة",
  "licensingUnit": "مدينة نصر",
  "issueDate": "2026-02-24",
  "expiryDate": "2029-02-24",
  "status": "سارية",
  "citizenName": "شريف عبدالله",
  "delivery": {
    "method": "TrafficUnit",
    "address": null
  }
}
```

---

### POST /DrivingLicense/renewal-request
🔒 Auth Required | طلب تجديد رخصة قيادة

No body required — الـ token بيحدد المواطن

---

### POST /DrivingLicense/finalize-renewal/{requestNumber}
🔒 Auth Required | إتمام تجديد الرخصة

**URL Param:** `requestNumber` — مثال: `DR-800`

**Body (JSON):**
```json
{
  "method": 2,
  "address": {
    "governorate": "Cairo",
    "city": "Nasr City",
    "details": "123 Street Name, Building 5"
  }
}
```

---

### POST /DrivingLicense/issue-replacement/{licenseNumber}
🔒 Auth Required | إصدار بدل فاقد/تالف

**URL Param:** `licenseNumber` — مثال: `DL-100004`

**Body (JSON):**
```json
{
  "replacementtype": "Lost",
  "delivery": {
    "method": 2,
    "address": {
      "governorate": "Cairo",
      "city": "Nasr City",
      "details": "123 Street Name, Building 5"
    }
  }
}
```

---

### GET /DrivingLicense/my-licenses
🔒 Auth Required | جلب كل رخص قيادة المواطن الحالي

No body — يرجع قائمة رخص المواطن المسجل

---

## 3. Vehicle License (رخصة السيارة)

### POST /VehicleLicense/upload-documents
🔒 Auth Required | رفع مستندات إصدار رخصة سيارة لأول مرة

**Body (form-data — يحتوي على ملفات):**
| Field | Type | Description |
|---|---|---|
| VehicleType | text | نوع السيارة (مثال: 0) |
| Brand | text | الماركة (مثال: تويوتا) |
| Model | text | الموديل (مثال: كورولا) |
| OwnershipProof | file | إثبات الملكية |
| VehicleDataCertificate | file | شهادة بيانات السيارة |
| IdCard | file | بطاقة الهوية |
| InsuranceCertificate | file | شهادة التأمين |

---

### POST /VehicleLicense/finalize/{requestNumber}
🔒 Auth Required | إتمام إصدار رخصة السيارة

**URL Param:** `requestNumber` — مثال: `VL-100`

**Body (JSON):**
```json
{
  "method": 2,
  "address": {
    "governorate": "Cairo",
    "city": "Nasr City",
    "details": "123 Street Name, Building 5"
  }
}
```

---

### POST /VehicleLicense/renew
🔒 Auth Required | طلب تجديد رخصة سيارة

**Body (form-data):**
| Field | Type |
|---|---|
| VehicleLicenseNumber | text (مثال: VL-200010) |

---

### POST /VehicleLicense/finalize-renewal/{requestNumber}
🔒 Auth Required | إتمام تجديد رخصة السيارة

**URL Param:** `requestNumber` — مثال: `VR-200`

**Body (JSON):**
```json
{
  "method": 2,
  "address": {
    "governorate": "Cairo",
    "city": "Nasr City",
    "details": "123 Street Name, Building 5"
  }
}
```

---

### POST /VehicleLicense/replacement/{licenseNumber}?type=lost|damaged
🔒 Auth Required | استبدال رخصة مفقودة أو تالفة

**URL Param:** `licenseNumber` — مثال: `VL-200001`
**Query Param:** `type` = `lost` أو `damaged`

**Body (JSON):**
```json
{
  "method": 2,
  "address": {
    "governorate": "Cairo",
    "city": "Nasr City",
    "details": "123 Street Name, Building 5"
  }
}
```

---

### GET /VehicleTypes
جلب أنواع السيارات المتاحة (لا تحتاج auth)

---

### GET /VehicleLicense/my-licenses
🔒 Auth Required | جلب رخص سيارات المواطن الحالي

---

## 4. Traffic Violations (المخالفات المرورية)

### GET /TrafficViolations/driving-license/{licenseNumber}
🔒 Auth Required | مخالفات رخصة قيادة معينة

**URL Param:** `licenseNumber` — مثال: `DL-100004`

---

### GET /TrafficViolations/vehicle-license/{licenseNumber}
🔒 Auth Required | مخالفات رخصة سيارة معينة

**URL Param:** `licenseNumber` — مثال: `VL-200003`

---

### GET /TrafficViolations/license/{licenseNumber}/details?licenseType=Driving|Vehicle
🔒 Auth Required | مخالفات مع تفاصيل كاملة

**URL Param:** `licenseNumber`
**Query Param:** `licenseType` = `Driving` أو `Vehicle`

---

## 5. Appointments (المواعيد)

### POST /appointments/book
🔒 Auth Required | حجز موعد

**Body (JSON):**
```json
{
  "serviceType": "فحص فني",
  "governorateId": 1,
  "trafficUnitId": 3,
  "date": "2026-03-29",
  "time": "10:30"
}
```

---

### GET /appointments/available-slots?date=YYYY-MM-DD&type=Medical
جلب المواعيد المتاحة (لا تحتاج auth)

**Query Params:**
- `date` — التاريخ بصيغة YYYY-MM-DD
- `type` — نوع الموعد (مثال: Medical)

---

### GET /appointments/my
🔒 Auth Required | مواعيدي الحالية

---

## 6. Payments (الدفع)

### POST /payment/create
🔒 Auth Required | إنشاء عملية دفع

**Body (JSON):**
```json
{
  "violationIds": [4, 5]
}
```

---

### GET /Payment/status/{orderId}
🔒 Auth Required | حالة الدفع

**URL Param:** `orderId` — مثال: `MOR-20260324-b9e35a22a73d48b49bd`

---

### GET /Payment/receipt/{orderId}
🔒 Auth Required | إيصال الدفع

**URL Param:** `orderId` — مثال: `MOR-20260323-86083afdfa164055a53`

---

### GET /payment/callback?success=true|false&merchant_order_id={orderId}
Paymob Webhook — لا تستخدم من Flutter مباشرة، هذا للـ backend فقط

---

## 7. Service Requests (طلبات الخدمة)

### GET /servicerequests/my-requests
🔒 Auth Required | جلب كل طلباتي

---

### GET /service-requests/{requestNumber}
🔒 Auth Required | تفاصيل طلب معين

**URL Param:** `requestNumber`

---

## 8. Staff (الموظفين)

### GET /staff/examinations
🔒 Auth Required (Staff Role) | جلب المواعيد للموظف المسجل

---

### POST /staff/submit
🔒 Auth Required (Staff Role) | تسجيل نتيجة فحص

**Body (JSON):**
```json
{
  "RequestNumber": "VR-200",
  "passed": true
}
```

---

## 9. Admin

### GET /AdminSeedData/citizens
🔒 Auth Required (Admin Role) | جلب بيانات المواطنين

### GET /AdminSeedData/vehicle-licenses
🔒 Auth Required (Admin Role) | جلب رخص السيارات

### GET /AdminSeedData/driving-licenses
🔒 Auth Required (Admin Role) | جلب رخص القيادة

### GET /adminusers
🔒 Auth Required (Admin Role) | جلب كل المستخدمين

### POST /adminusers
🔒 Auth Required (Admin Role) | إنشاء مستخدم جديد

**Body (JSON):**
```json
{
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "role": "Citizen",
  "password": "StrongPassword123!"
}
```

### PUT /adminusers/{id}
🔒 Auth Required (Admin Role) | تعديل مستخدم

**URL Param:** `id` — الـ UUID

**Body (JSON):**
```json
{
  "firstName": "Jane",
  "lastName": "Doe",
  "role": "Admin",
  "email": "newemail@example.com"
}
```

### DELETE /adminusers/{id}
🔒 Auth Required (Admin Role) | حذف مستخدم

**URL Param:** `id` — الـ UUID

---

## ملاحظات مهمة للـ AI Agent

1. **Bearer Token**: يُخزَّن بعد الـ Login ويُرسَل في كل request محمي
2. **Form-data مع ملفات**: endpoints الـ upload-documents تستخدم `multipart/form-data` مش JSON
3. **Request Numbers**: بتيجي من الـ backend بعد upload-documents وتُستخدم في الـ finalize
4. **Delivery method**: القيمة `2` = توصيل، `1` = استلام من وحدة المرور (على الأرجح)
5. **Payment IDs**: بتبدأ بـ `MOR-` وبتيجي من الـ backend
