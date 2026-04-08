# Morourak API Documentation

# Morourak API Collection

**Morourak** is a traffic and licensing management platform — similar to a DMV (Department of Motor Vehicles) — that enables citizens, staff, and administrators to manage driving licenses, vehicle licenses, traffic violations, appointments, and payments through a unified API.

The base URL is configured via the `{{baseUrl}}` collection variable. Set this in your active environment before sending requests.

---

## Functional Areas

### Authentication

Handles user registration and login flows, including OTP verification, password recovery, and password reset.

### Driving License

Covers the full lifecycle of a driving license:

- **Issuance (First Time):** Upload required documents and finalize the license.
    
- **Renewal:** Submit a renewal request and finalize it.
    
- **Replacement:** Issue a replacement for a lost or damaged license.
    
- **Management:** Retrieve all licenses associated with a citizen.
    

### Vehicle License

Covers the full lifecycle of a vehicle license:

- **Issuance (First Time):** Upload initial documents and finalize the license.
    
- **Renewal:** Renew an existing vehicle license and finalize the process.
    
- **Replacement:** Replace a lost or damaged vehicle license.
    
- **Management:** Retrieve available vehicle types and the citizen's own licenses.
    

### Traffic Violations

Query traffic violations linked to driving or vehicle licenses, with support for detailed violation breakdowns by license.

### Appointments

Book appointments, check available time slots, and view upcoming or past appointments.

### Payments

Initiate payments, check payment status, retrieve receipts, and handle Paymob payment gateway callbacks/webhooks.

### Service Requests

View all service requests submitted by the authenticated citizen and retrieve details for a specific request.

### Staff

Allows staff members to view their assigned examination appointments and submit examination results for applicants.

### Admin

Administrative operations including:

- **Data Management:** Seed and retrieve data for citizens, vehicle licenses, and driving licenses.
    
- **Users Management:** Full CRUD operations for managing system users.
    

---

## Intended Users

| Role | Description |
| --- | --- |
| **Citizens** | Apply for, renew, or replace driving and vehicle licenses; book appointments; make payments. |
| **Staff** | Manage examination appointments and submit results for license applicants. |
| **Admins** | Oversee platform data, manage users, and access seed data for system setup. |

## Authentication

### POST http://morourak.runasp.net/api/v1/Auth/register

**Name:** Register

## Register Citizen

Registers a new citizen account in the system. This endpoint creates a user profile with the provided personal and authentication details.

---

### Request Body

| Field | Type | Required | Description |
|---|---|---|---|
| `nationalId` | `string` | ✅ Yes | The citizen's national ID number. Must be a valid 14-digit Egyptian national ID (e.g., `30003012345678`). |
| `mobileNumber` | `string` | ✅ Yes | The citizen's mobile phone number. Should follow Egyptian format (e.g., `01234567890`). |
| `username` | `string` | ✅ Yes | A unique username for the account (e.g., `citizen.test`). |
| `email` | `string` | ✅ Yes | A valid email address for the citizen (e.g., `user@example.com`). |
| `firstName` | `string` | ✅ Yes | The citizen's first name. Supports Arabic characters (e.g., `أحمد`). |
| `lastName` | `string` | ✅ Yes | The citizen's last name. Supports Arabic characters (e.g., `علي`). |
| `password` | `string` | ✅ Yes | The account password. Must meet complexity requirements (see notes below). |
| `confirmPassword` | `string` | ✅ Yes | Must exactly match the `password` field. |

---

### Notes

- **National ID**: Must be a 14-digit numeric string matching the Egyptian national ID format.
- **Mobile Number**: Should be a valid Egyptian mobile number starting with `01` and 11 digits total.
- **Password Complexity**: Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character (e.g., `Password123!`).
- **Password Confirmation**: `confirmPassword` must be identical to `password` or the request will be rejected.
- **Arabic Name Support**: `firstName` and `lastName` fields fully support Arabic (RTL) characters.
- **Unique Constraints**: Both `username` and `email` must be unique across the system. Duplicate values will result in a conflict error.

**Body (raw):**
```json
{
"nationalId": "31625121245678",
            "mobileNumber": "01090004444",
            "firstName": "ندى",
            "lastName": "حسين",
            "Email": "optify930@gmail.com", 
  "username": "nadaaaaa",
  "password": "Password123!",
  "confirmPassword": "Password123!"
}

```

### POST http://morourak.runasp.net/api/v1/Auth/verify-otp

**Name:** Verify OTP

## Verify OTP

Verifies a One-Time Password (OTP) for a given email address. This endpoint is typically called after an OTP has been sent to the user's email, as part of an authentication or account verification flow.

---

### Request Body

The request body must be sent as **raw JSON** with the following fields:

| Field   | Type   | Required | Description                                      |
|---------|--------|----------|--------------------------------------------------|
| `email` | string | ✅ Yes   | The email address associated with the OTP request. |
| `code`  | string | ✅ Yes   | The OTP code received by the user via email.     |

**Example:**
```json
{
  "email": "user@example.com",
  "code": "123456"
}
```

---

### Notes

- The `code` field should be sent as a **string**, even though it consists of numeric digits.
- OTP codes are typically **time-sensitive** — make sure to verify within the allowed expiry window.
- On successful verification, the server may return an authentication token or a success status to proceed with the next step in the flow.
- If the OTP is invalid or expired, the server will return an appropriate error response.

**Body (raw):**
```json
{
  "email": "optify930@gmail.com",
  "code": "113321"
}

```

### POST http://morourak.runasp.net/api/v1/Auth/login

**Name:** Login

## Login

Authenticates a user and returns an access token upon successful login.

**Endpoint:** `POST {{baseUrl}}/api/Auth/login`

---

### Request Body

The request body must be sent as JSON (`application/json`).

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `mobileNumber` | string | ✅ Yes | The registered mobile number of the user |
| `password` | string | ✅ Yes | The user's account password |

### Example Request Body

``` json
{
  "mobileNumber": "01234567890",
  "password": "Password123!"
}

 ```

---

### Success Response

On successful authentication, the endpoint returns an access token along with user details that can be used to authorize subsequent requests.

**Body (raw):**
```json
{
  "mobileNumber": "01090004444",
  "password": "Password123!"
}

```

## Profile

### GET http://morourak.runasp.net/api/v1/auth/profile

**Name:** View Profile

### POST http://morourak.runasp.net/api/v1/Auth/forgot-password

**Name:** Forgot-Password

## Forgot Password

Initiates the password reset flow for a registered user. When a valid email address is submitted, the server sends a password reset email to that address containing a link or token the user can use to set a new password.

---

### Request Body

The request body must be sent as **JSON** (`application/json`).

| Field   | Type   | Required | Description                                      |
|---------|--------|----------|--------------------------------------------------|
| `email` | string | ✅ Yes   | The email address associated with the user's account. |

**Example:**
```json
{
  "email": "shancysoliman@gmail.com"
}
```

---

### Expected Behavior

- **200 OK** — The request was processed successfully. A password reset email has been sent to the provided address (if an account with that email exists).
- **400 Bad Request** — The request body is invalid or the `email` field is missing/malformed.
- **404 Not Found** — No account is associated with the provided email address (behavior may vary depending on server security policy — some APIs return `200` regardless to prevent email enumeration).

> **Note:** For security reasons, some implementations return a `200 OK` response even if the email is not found in the system, to avoid revealing whether an account exists.

**Body (raw):**
```json
{
  "email": "shancysoliman@gmail.com"
}

```

### POST http://morourak.runasp.net/api/v1/Auth/reset-password

**Name:** Reset-Password

## Reset Password

Resets a user's account password using a verification code that was previously sent to their email address (e.g., via a "Forgot Password" flow).

**Method:** `POST`  
**URL:** `{{baseUrl}}/api/Auth/reset-password`

---

### Request Body

The request body must be sent as **raw JSON** with the following fields:

| Field | Type | Required | Description |
|---|---|---|---|
| `email` | `string` | ✅ Yes | The email address of the account whose password is being reset. |
| `code` | `string` | ✅ Yes | The verification/OTP code sent to the user's email to authorize the password reset. |
| `newPassword` | `string` | ✅ Yes | The new password to set for the account. Should meet the application's password strength requirements. |

---

### Example Request Body

```json
{
  "email": "shancysoliman@gmail.com",
  "code": "284668",
  "newPassword": "NewPass123!"
}
```

---

### Notes
- The `code` is time-sensitive and typically expires after a short period.
- Ensure the `newPassword` meets the required complexity rules (e.g., uppercase, lowercase, numbers, special characters).
- This endpoint should be called after the user has received a reset code via the forgot-password flow.

**Body (raw):**
```json
{
  "email": "shancysoliman@gmail.com",
  "code": "284668",
  "newPassword": "NewPass123!"
}
```

### POST http://morourak.runasp.net/api/v1/auth/change-email/request

**Name:** Change-Email

**Body (raw):**
```json
{
  "newEmail": "shahdmohammed1511@gmail.com"
}
```

### POST http://morourak.runasp.net/api/v1/auth/change-email/confirm

**Name:** Confirm Change-Email

**Body (raw):**
```json
{
  "newEmail": "shahdmohammed1511@gmail.com",
  "code": "914702"
}
```

## Driving License

### Issuance (First Time)

### POST http://morourak.runasp.net/api/v1/DrivingLicense/upload-documents

**Name:** Upload Documents



## License Issuance Request — Upload Documents

بدء طلَب إصدار رخصة قيادة جديدة من خلال رفع المستندات القانونية المطلوبة.

---

### Endpoint Details

| Property | Value |
| --- | --- |
| **Method** | `POST` |
| **URL** | `/api/v1/DrivingLicense/upload-documents` |
| **Authorization** | `Role/CITIZEN` |
| **Content-Type** | `multipart/form-data` |

---

### Request Body Parameters

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `category` | `integer` (enum) | ✅ Yes | فئة الرخصة (مثلاً: `1` = ملاكي). |
| `personalPhoto` | `file` | ✅ Yes | الصورة الشخصية للمتقدم. |
| `educationalCertificate` | `file` | ✅ Yes | الشهادة الدراسية. |
| `idCard` | `file` | ✅ Yes | بطاقة الرقم القومي. |
| `residenceProof` | `file` | ❌ No| إثبات محل الإقامة. |
| `medicalCertificate` | `file` | ❌ No | **شهادة طبية معتمدة.** في حال رفعها، يتم تخطي مرحلة حجز الكشف الطبي. |

---

### Request Example

```http
POST /api/v1/DrivingLicense/upload-documents
Content-Type: multipart/form-data

category: 1
personalPhoto: [ملف صورة]
educationalCertificate: [ملف شهادة]
idCard: [ملف بطاقة]
residenceProof: [ملف إثبات إقامة]
medicalCertificate: [ملف شهادة طبية - اختياري]
```

---

### Response Example

```json
{
  "isSuccess": true,
  "message": "تم رفع المستندات بنجاح",
  "details": {
    "id": 15,
    "requestNumber": "LR-202612345",
    "status": "Pending",
    "submittedAt": "2026-04-03T20:38:00Z"
  }
}
```

---

### Validation Rules (Logic)

1.  **المستندات الأساسية**: الـ `personalPhoto` و `educationalCertificate` و `idCard` و `residenceProof` إلزامية كملفات.
2.  **الكشف الطبي (XOR Logic)**:
    *   إذا قام المستخدم برفع `medicalCertificate`: يتم تعديل حالة الكشف الطبي في الطلب إلى **"مجتاز"** تلقائياً، ويُمنع لاحقاً من حجز موعد كشف طبي من خلال الـ API.
    *   إذا لم يتم رفعها: يظل الكشف الطبي مطلوباً، ويجب على المستخدم حجز موعد كشف طبي من خلال قسم المواعيد.
3.  **الموقع**: تم إلغاء حقول المحافظة ووحدة المرور من هذا الريكويست لأن المستخدم سيقوم باختيارهم لاحقاً أثناء حجز المواعيد.

---

### Error Responses

| Status Code | Description |
| --- | --- |
| `400 Bad Request` | "بيانات غير صالحة" أو "لم يتم استلام أي ملفات". |
| `401 Unauthorized` | الـ Token غير صالح أو الـ NationalId غير موجود. |
| `409 Conflict` | "لديك طلب رخصة قيادة قيد الانتظار بالفعل". |

---

### Service Dependencies

- **`IDrivingLicenseService`**
    - `UploadInitialDocumentsAsync`: تقوم بحفظ الملفات وتحديد ما إذا كان المستخدم مؤهلاً للانتقال مباشرة لاختبار القيادة (في حال رفع الشهادة الطبية).

**Body (form-data):**
- `category`: text (value: قيادة خاصة)
- `personalPhoto`: file (value: None)
- `educationalCertificate`: file (value: None)
- `idCard`: file (value: None)
- `residenceProof`: file (value: None)
- `medicalCertificate`: file (value: None)

### POST http://morourak.runasp.net/api/v1/DrivingLicense/finalize/DL-500

**Name:** Finalize License

## Finalize Driving License

Finalizes a driving license application by confirming the delivery method and address details. Once finalized, the license is issued and becomes active with a set expiry date.

---

### Endpoint

```
POST {{baseUrl}}/api/DrivingLicense/finalize/{licenseNumber}

 ```

**Path Variable:** `licenseNumber` — The driving license identifier (e.g., `DL-500`).

---

### Request Body

The request body must be sent as raw JSON.

``` json
{
  "method": 2,
  "address": {
    "governorate": "Cairo",
    "city": "Nasr City",
    "details": "123 Street Name, Building 5"
  }
}

 ```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `method` | integer | ✅ | Delivery method for the license. See values below. |
| `address` | object | Conditional | Delivery address details. Required when `method` is not `TrafficUnit`. |
| `address.governorate` | string | Conditional | The governorate for delivery (e.g., `"Cairo"`). |
| `address.city` | string | Conditional | The city for delivery (e.g., `"Nasr City"`). |
| `address.details` | string | Conditional | Street-level address details (e.g., building number, street name). |

#### `method` Field Values

| Value | Meaning |
| --- | --- |
| `1` | **TrafficUnit** — The license is picked up from the traffic unit office. No address is required. |
| `2` | **HomeDelivery** — The license is delivered to the provided address. Address fields are required. |

---

### Response (200 OK)

A successful response returns the finalized license details.

``` json
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

| Field | Type | Description |
| --- | --- | --- |
| `id` | integer | Internal record ID of the finalized license. |
| `drivingLicenseNumber` | string | The official issued license number. |
| `category` | string | License category (e.g., `درجة أولى` = First Class). |
| `governorate` | string | The governorate where the license was issued. |
| `licensingUnit` | string | The specific traffic/licensing unit that issued the license. |
| `issueDate` | string (date) | The date the license was issued (`YYYY-MM-DD`). |
| `expiryDate` | string (date) | The date the license expires (`YYYY-MM-DD`). |
| `status` | string | Current license status (e.g., `سارية` = Active/Valid). |
| `citizenName` | string | Full name of the license holder. |
| `delivery.method` | string | The delivery method used (`TrafficUnit` or `HomeDelivery`). |
| `delivery.address` | object | null |

---

### Saved Examples

| Example Name | Description |
| --- | --- |
| **Finalize License - Traffic Unit** | Demonstrates finalization with `method: 1` (TrafficUnit pickup). No address required. |
| **Finalize License** | General finalization example with address-based delivery. |

---

### Notes

- The license number in the URL path (e.g., `DL-500`) must correspond to an existing, pending driving license application.
    
- When `method` is `1` (TrafficUnit), the `address` object may be omitted or set to `null`.
    
- The `status` and `category` fields in the response are returned in Arabic.
    
- License validity is typically **3 years** from the issue date.

**Body (raw):**
```json
{
  "method": "توصيل للمنزل", 
  "address": {
    "governorate": "القاهرة",
    "city": "مدينة نصر",
    "details": "123 Street Name, Building 5"
  }
}

```

### Renewal

### POST http://morourak.runasp.net/api/v1/DrivingLicense/renewal-request

**Name:** Renewal-Request

## Renewal Request

Submits a driving license renewal request for the currently authenticated user. The request allows the applicant to optionally upgrade to a new license category as part of the renewal process.

---

**Method:** `POST`  
**URL:** `{{baseUrl}}/api/DrivingLicense/renewal-request`

---

## Request Body

**Content-Type:** `multipart/form-data`

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `NewCategory` | `string` | Optional | The new driving license category being requested (e.g. `ProfessionalThirdDegree`). If omitted, the renewal is submitted without a category upgrade. |

---

## Response

### 200 OK

Returns the details of the newly created renewal request.

``` json
{
  "id": 2,
  "drivingLicenseNumber": "DL-100005",
  "currentCategory": "درجة ثانية",
  "requestedCategory": "درجة ثالثة",
  "status": "Pending",
  "requestNumber": "DR-801"
}

 ```

| Field | Type | Description |
| --- | --- | --- |
| `id` | `integer` | Unique identifier of the renewal request |
| `drivingLicenseNumber` | `string` | The applicant's current driving license number |
| `currentCategory` | `string` | The applicant's current license category |
| `requestedCategory` | `string` | The new category requested (if applicable) |
| `status` | `string` | Current status of the request (e.g. `Pending`) |
| `requestNumber` | `string` | A human-readable reference number for the request |

---

## Saved Examples

- **Renewal-Request within update category** — Demonstrates a renewal request that includes a category upgrade.
    
- **Renewal-Request without update category** — Demonstrates a standard renewal request with no category change.

**Body (form-data):**

### POST http://morourak.runasp.net/api/v1/DrivingLicense/finalize-renewal/DR-800

**Name:** Finalize-Renewal

## Finalize Driving License Renewal

Finalizes the renewal process for a driving license identified by its license number in the URL path. This endpoint confirms the renewal and sets the delivery preferences for the renewed license.

---

### Request Body

The request body must be sent as **JSON** with the following fields:

| Field | Type | Required | Description |
|---|---|---|---|
| `method` | `integer` | ✅ | Delivery method. Use `2` for **HomeDelivery**. |
| `address` | `object` | ✅ | Delivery address details (required when method is HomeDelivery). |
| `address.governorate` | `string` | ✅ | The governorate for delivery (e.g., `"Cairo"`). |
| `address.city` | `string` | ✅ | The city for delivery (e.g., `"Nasr City"`). |
| `address.details` | `string` | ✅ | Full address details (e.g., `"123 Street Name, Building 5"`). |

**Example Request Body:**
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

### Response

On success, the endpoint returns **HTTP 200 OK** with the updated driving license details.

| Field | Type | Description |
|---|---|---|
| `id` | `integer` | Internal record ID of the driving license. |
| `drivingLicenseNumber` | `string` | The unique driving license number (e.g., `"DL-100005"`). |
| `category` | `string` | License category (e.g., `"درجة ثالثة"`). |
| `governorate` | `string` | Governorate where the license was issued. |
| `licensingUnit` | `string` | The licensing unit responsible for issuance. |
| `issueDate` | `string (date)` | Date the license was issued (`YYYY-MM-DD`). |
| `expiryDate` | `string (date)` | Date the license expires (`YYYY-MM-DD`). |
| `status` | `string` | Current status of the license (e.g., `"تجديد جاري"`). |
| `citizenName` | `string` | Full name of the license holder. |
| `delivery` | `object` | Delivery information including method and address. |
| `delivery.method` | `string` | Delivery method label (e.g., `"HomeDelivery"`). |
| `delivery.address` | `object` | Delivery address with `governorate`, `city`, and `details`. |

**Example Response:**
```json
{
  "id": 5,
  "drivingLicenseNumber": "DL-100005",
  "category": "درجة ثالثة",
  "governorate": "السويس",
  "licensingUnit": "وحدة مرور السويس",
  "issueDate": "2026-02-24",
  "expiryDate": "2029-02-24",
  "status": "تجديد جاري",
  "citizenName": "مريم علي",
  "delivery": {
    "method": "HomeDelivery",
    "address": {
      "governorate": "Cairo",
      "city": "Nasr City",
      "details": "123 Street Name, Building 5"
    }
  }
}
```

**Body (raw):**
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

### Replacement

### POST http://morourak.runasp.net/api/v1/api/DrivingLicense/issue-replacement/DL-100004

**Name:** Issue-Replacement

**Body (raw):**
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

### Management

### GET http://morourak.runasp.net/api/v1/DrivingLicense/my-licenses

**Name:** Get All Licenses By Citizen

## Get All Driving Licenses for Authenticated Citizen

Retrieves a list of all driving licenses associated with the currently authenticated citizen. Each record contains full license details including category, status, issuing unit, and validity dates.

---

### Authentication

This endpoint requires a valid **Bearer Token**. The token is obtained after a successful login and must be included in the `Authorization` header:

```
Authorization: Bearer {{token}}

 ```

> Make sure you are logged in and have a valid token before calling this endpoint. 
  

---

### Response Fields

| Field | Type | Description |
| --- | --- | --- |
| `licenseNumber` | `string` | Unique identifier for the driving license (e.g., `DL-100003`) |
| `category` | `string` | License category / vehicle type (e.g., motorcycle, car) |
| `status` | `string` | Current status of the license (e.g., active, renewal in progress) |
| `citizenNationalId` | `string` | National ID of the license holder |
| `licensingUnit` | `string` | The traffic unit that issued the license |
| `governorate` | `string` | The governorate where the license was issued |
| `issueDate` | `string (date)` | Date the license was issued (`YYYY-MM-DD`) |
| `expiryDate` | `string (date)` | Date the license expires (`YYYY-MM-DD`) |

---

### Example Response `200 OK`

``` json
[
  {
    "licenseNumber": "DL-100003",
    "category": "دراجة نارية",
    "status": "تجديد جاري",
    "citizenNationalId": "30003012345678",
    "licensingUnit": "وحدة مرور سيدي جابر",
    "governorate": "الإسكندرية",
    "issueDate": "2026-02-24",
    "expiryDate": "2029-02-24"
  }
]

 ```

## Vehicle License

### Issuance (First Time)

### POST http://morourak.runasp.net/api/v1/VehicleLicense/upload-documents

**Name:** Upload Initial Documents

**Body (form-data):**
- `VehicleType`: text (value: ملاكي)
- `Brand`: text (value: تويوتا)
- `Model`: text (value: كورولا)
- `OwnershipProof`: file (value: None)
- `VehicleDataCertificate`: file (value: None)
- `IdCard`: file (value: None)
- `InsuranceCertificate`: file (value: None)
- `CustomClearance`: file (value: None)
- `InsuranceCompanyId`: text (value: 1)

### POST http://morourak.runasp.net/api/v1/VehicleLicense/finalize/VL-100

**Name:** Finalize License

**Body (raw):**
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

### Renewal

### POST http://morourak.runasp.net/api/v1/VehicleLicense/renew

**Name:** Renew License

**Body (form-data):**
- `VehicleLicenseNumber`: text (value: VL-200002)

### POST http://morourak.runasp.net/api/v1/VehicleLicense/finalize-renewal/VR-200

**Name:** Finalize Renewal

**Body (raw):**
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

### Replacement

### POST http://morourak.runasp.net/api/v1/VehicleLicense/replacement/VL-200001?type=lost

**Name:** Replace lost license

**Body (raw):**
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

### POST http://morourak.runasp.net/api/v1/VehicleLicense/replacement/{licenseNumber}?type=damaged

**Name:** Replace damaged license

**Body (raw):**
```json
{
 "method": "Delivery",
 "address": "Cairo",
 "phone": "01012345678"
}
```

### Management

### GET http://morourak.runasp.net/api/v1/VehicleTypes

**Name:** Get Vehicle Types

### GET http://morourak.runasp.net/api/v1/VehicleLicense/my-licenses

**Name:** Get My Licenses

### GET http://morourak.runasp.net/api/v1/VehicleLicense/insurance-companies

**Name:** Get Insurance-Companies

## Traffic Violations

### Query

### GET http://morourak.runasp.net/api/v1/TrafficViolations/driving-license/DL-100004

**Name:** Get Driving License Violations

## Get Driving License Violations

Retrieves all traffic violations associated with a specific driving license number. The response includes detailed information about each violation, along with summary totals for unpaid fines.

---

### Method & URL

```
GET {{baseUrl}}/api/TrafficViolations/driving-license/{licenseNumber}
```

---

### Authentication

This endpoint requires a **Bearer Token (JWT)** in the `Authorization` header.

```
Authorization: Bearer {{token}}
```

---

### Path Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `licenseNumber` | `string` | Yes | The driving license number to query violations for (e.g. `DL-100002`) |

---

### Response Fields

#### Top-Level Fields

| Field | Type | Description |
|---|---|---|
| `violations` | `array` | List of traffic violation objects associated with the license |
| `totalCount` | `integer` | Total number of violations found |
| `unpaidCount` | `integer` | Number of violations that have not been paid |
| `totalPayableAmount` | `number` | Total outstanding amount due across all unpaid violations |
| `message` | `string \| null` | Optional message in English (may be `null`) |
| `messageAr` | `string` | Summary message in **Arabic** describing unpaid violations and total amount |

#### Violation Object Fields

| Field | Type | Description |
|---|---|---|
| `violationId` | `integer` | Unique identifier for the violation |
| `violationNumber` | `string` | Human-readable violation reference number (e.g. `MV-2025-005`) |
| `violationType` | `string` | Type/category of the violation (e.g. `SpeedLimitExceeded`, `SeatBeltViolation`) |
| `legalReference` | `string` | Legal article reference from the traffic law *(in Arabic)* |
| `description` | `string` | Detailed description of the violation *(in Arabic)* |
| `location` | `string` | Location where the violation occurred *(in Arabic)* |
| `violationDateTime` | `string` | Date and time of the violation *(formatted in Arabic)* |
| `fineAmount` | `number` | Total fine amount issued for the violation |
| `paidAmount` | `number` | Amount already paid toward the fine |
| `remainingAmount` | `number` | Remaining unpaid balance |
| `status` | `string` | Payment status of the violation *(in Arabic)* |
| `statusAr` | `string` | Payment status in **Arabic** (e.g. `غير مدفوعة` = Unpaid) |
| `isPayable` | `boolean` | Indicates whether the violation can currently be paid online |

---

### Example Response

```json
{
  "violations": [
    {
      "violationId": 5,
      "violationNumber": "MV-2025-005",
      "violationType": "SpeedLimitExceeded",
      "legalReference": "المادة 72 / قانون المرور - تجاوز السرعة ...",
      "description": "تجاوز السرعة القصوى بمقدار 25 كم/ساعة",
      "location": "الطريق الدائري، المعادي",
      "violationDateTime": "28 فبراير 2025 - 08:30 ص",
      "fineAmount": 1000,
      "paidAmount": 0,
      "remainingAmount": 1000,
      "status": "غير مدفوعة",
      "statusAr": "غير مدفوعة",
      "isPayable": true
    }
  ],
  "totalCount": 2,
  "unpaidCount": 2,
  "totalPayableAmount": 1500,
  "message": null,
  "messageAr": "يوجد 2 مخالفة غير مدفوعة. إجمالي المبلغ ..."
}
```

---

> **Note:** Several fields in the response are returned in **Arabic**, including `legalReference`, `description`, `location`, `violationDateTime`, `status`, `statusAr`, and `messageAr`. Ensure your application handles Arabic (RTL) text appropriately when displaying these values.

### GET http://morourak.runasp.net/api/v1/TrafficViolations/vehicle-license/VL-200002

**Name:** Get Vehicle License Violations

### GET http://morourak.runasp.net/api/v1/TrafficViolations/license/DL-100004/details?licenseType=Driving

**Name:** Get Violations by License with Details

## Appointments & Locations

### Lookups

### GET http://morourak.runasp.net/api/v1/governorates

**Name:** Get All Governorates

### GET http://morourak.runasp.net/api/v1/governorates/1/traffic-units

**Name:** Get Traffic Units by Governorate

### Booking Flow

### GET http://morourak.runasp.net/api/v1/appointments/available-slots?date=2026-03-25&type=Medical

**Name:** Get Available Slots

# Get Available Slots

## Overview

This endpoint retrieves available examination slots for a specified date and examination type. Use this to check slot availability before booking an appointment.

## Query Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | string | Yes | The date to check for available slots. Must be in **YYYY-MM-DD** format (e.g., `2025-01-10`) |
| `type` | string | Yes | The type of examination to check availability for (e.g., `Medical`) |

## Expected Response Format

The response will contain a list of available time slots for the specified date and examination type, including:

- Slot identifiers
    
- Time ranges
    
- Availability status
    
- Any additional slot metadata
    

## Example Usage Scenario

**Scenario:** A citizen wants to book a medical examination and needs to see what time slots are available on January 10, 2025.

**Request:**

```
GET {{baseUrl}}/appointments/available-slots?date=2025-01-10&type=Medical

 ```

**Use Case:** The application can display the available slots to the user, allowing them to select a convenient time for their medical examination appointment.

### POST http://morourak.runasp.net/api/v1/appointments/book

**Name:** Book Appointment

Allows users to book an appointment for a specific examination type (Medical, Driving, or Technical/Inspection). The system creates a new appointment entry with the specified type, date, and start time.

**Authentication:**  
Bearer token required (role must be `Citizen`).

---

### Request Body

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| type | string | Yes | Type of examination (`"Medical"`, `"Driving"`, `"`Technical`"`) |
| date | string | Yes | Appointment date in `YYYY-MM-DD` format (must be in the future) |
| startTime | string | Yes | Appointment start time in `HH:MM` 24-hour format |

**Example JSON Request:**

``` json
{
  "type": "Medical",
  "date": "2025-01-10",
  "startTime": "09:15"
}

 ```

---

### Responses

#### 1\. Success – Appointment Booked

- **HTTP Status:** `201 Created`
    
- **Body:**
    

``` json
{
  "serviceNumber": "SR123456",
  "applicationId": 101,
  "date": "2025-01-10",
  "startTime": "09:15",
  "status": "Scheduled",
  "nationalId": "12345678901234",
  "type": "Medical"
}

 ```

- Notes:
    - `type` will reflect the booked examination.
        
    - `status` starts as `"Scheduled"`.
        

---

#### 2\. Bad Request – Invalid or Missing Fields

- **HTTP Status:** `400 Bad Request`
    
- **Body Examples:**
    

``` json
{
  "error": "Request body is missing or invalid",
  "code": "BODY_MISSING"
}

 ```

or

``` json
{
  "error": "Invalid date or time format",
  "code": "INVALID_FORMAT"
}

 ```

- Causes:
    - Missing `type`, `date`, or `startTime`.
        
    - `date` not in `YYYY-MM-DD`.
        
    - `startTime` not in `HH:MM`.
        
    - `date` in the past.
        

---

#### 3\. Unauthorized – User Not Authenticated

- **HTTP Status:** `401 Unauthorized`
    
- **Body:**
    

``` json
{
  "error": "User not authenticated",
  "code": "AUTH_ERROR"
}

 ```

- Cause: Missing or invalid token.
    

---

#### 4\. Forbidden – User Not Allowed

- **HTTP Status:** `403 Forbidden`
    
- **Body:**
    

``` json
{
  "error": "You are not authorized to book this type of appointment",
  "code": "AUTHZ_ERROR"
}

 ```

- Cause: Role not allowed to book (e.g., staff roles).
    

---

#### 5\. Conflict – Time Slot Already Taken

- **HTTP Status:** `409 Conflict`
    
- **Body:**
    

``` json
{
  "error": "This time slot is no longer available",
  "code": "SLOT_UNAVAILABLE"
}

 ```

- Cause: Another appointment exists at the same date, startTime, and type.
    

---

#### 6\. Conflict – Citizen Already Has Appointment at Same Time

- **HTTP Status:** `409 Conflict`
    
- **Body:**
    

``` json
{
  "error": "You already have another appointment at this date and time",
  "code": "CITIZEN_BOOKING_CONFLICT"
}

 ```

- Cause: Citizen has another appointment (any type) at the same date and time.
    

---

#### 7\. Internal Server Error

- **HTTP Status:** `500 Internal Server Error`
    
- **Body:**
    

``` json
{
  "error": "An unexpected server error occurred",
  "code": "SYSTEM_ERROR"
}

 ```

- Cause: Database or repository error.
    

---

### Notes / Best Practices

- `type` must be one of: `"Medical"`, `"Driving"`, `"Technical"`.
    
- Check **slot availability** before booking.
    
- All dates must be **future dates**.
    
- Start times must be in **24-hour HH:MM format**.
    
- Authentication required (`Bearer` ).
    
- Conflicts will return `409 Conflict`; users should pick another slot.

**Body (raw):**
```json
{
  "serviceType": "قيادة عملي",
  "governorateId": "القاهرة",
  "trafficUnitId": "مرور غرب القاهرة",
  "date": "2026-04-26",
  "time": "11:30"
}
```

### GET http://morourak.runasp.net/api/v1/appointments/my

**Name:** My Appointments

# Get My Examinations

## Description

This endpoint retrieves all examinations/appointments associated with the currently authenticated user. It returns a list of the user's scheduled, completed, or pending medical examinations.

## Authentication

**Required:** Yes

This endpoint requires user authentication. The authenticated user's identity is used to filter and return only their personal examination records. Include a valid authentication token in your request headers.

## Request Details

### HTTP Method

`GET`

### Endpoint

```
{{baseUrl}}/api/examinations/my

 ```

### Headers

| Header | Value | Required | Description |
| --- | --- | --- | --- |
| Authorization | Bearer {token} | Yes | Authentication token for the current user |
| Content-Type | application/json | No | Specifies the response format |

### Query Parameters

This endpoint may support optional query parameters for filtering or pagination:

- `status` - Filter by examination status (e.g., scheduled, completed, cancelled)
    
- `date` - Filter by examination date
    
- `limit` - Number of results to return
    
- `offset` - Pagination offset
    

## Response Format

### Success Response (200 OK)

``` json
{
  "success": true,
  "data": [
    {
      "id": "string",
      "examinationType": "string",
      "scheduledDate": "ISO 8601 datetime",
      "status": "scheduled|completed|cancelled",
      "location": "string",
      "doctor": {
        "id": "string",
        "name": "string"
      },
      "notes": "string"
    }
  ],
  "count": "number"
}

 ```

### Error Responses

**401 Unauthorized**

``` json
{
  "success": false,
  "error": "Authentication required"
}

 ```

**403 Forbidden**

``` json
{
  "success": false,
  "error": "Access denied"
}

 ```

**500 Internal Server Error**

``` json
{
  "success": false,
  "error": "Server error message"
}

 ```

## Use Cases

1. **Patient Dashboard**: Display all upcoming and past examinations on the user's dashboard
    
2. **Appointment History**: Allow users to view their complete examination history
    
3. **Reminder System**: Fetch upcoming examinations to send reminders to users
    
4. **Medical Records**: Retrieve examination data for generating medical reports
    
5. **Mobile App Sync**: Synchronize examination data with mobile applications
    

## Example Usage

### Request

``` bash
curl --location '{{baseUrl}}/api/examinations/my' \
--header 'Authorization: Bearer YOUR_AUTH_TOKEN'

 ```

### Response

``` json
{
  "success": true,
  "data": [
    {
      "id": "exam_123",
      "examinationType": "Blood Test",
      "scheduledDate": "2024-01-15T10:00:00Z",
      "status": "scheduled",
      "location": "Main Clinic - Room 201",
      "doctor": {
        "id": "doc_456",
        "name": "Dr. Smith"
      },
      "notes": "Fasting required"
    }
  ],
  "count": 1
}

 ```

## Notes

- Results are automatically filtered to show only the authenticated user's examinations
    
- Ensure the authentication token is valid and not expired
    
- The response may be paginated for users with many examinations

## Payments

### POST http://morourak.runasp.net/api/v1/payment/create

**Name:** Initiate/Create Payment

## Initiate / Create Payment

Initiates a new payment session for one or more driving license violations. This endpoint integrates with **Paymob** as the payment gateway and returns a payment token and a redirect URL to complete the transaction.

---

### Authentication

Requires a valid **Bearer Token** in the `Authorization` header.

```
Authorization: Bearer <token>

 ```

---

### Request Body

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `violationIds` | `integer[]` | No | Array of violation IDs to be paid in this session. |
| `ServiceRequestNumber` | `string` | No | Number of Service to be paid in this session. |

**Example:**

``` json
{
  "ServiceRequestNumber": "DL-500",
  "violationIds": [4, 5]
}

 ```

---

### Response

**Status:** **`200 OK`**

| Field | Type | Description |
| --- | --- | --- |
| `paymentToken` | `string` | JWT token used to authenticate the Paymob payment session. |
| `paymentId` | `integer` | Internal ID of the created payment record. |
| `paymobOrderId` | `string` | The order ID generated by Paymob. |
| `merchantOrderId` | `string` | The merchant-side order reference (format: `MOR-{date}-{uuid}`). |
| `paymentUrl` | `string` | The Paymob-hosted URL to redirect the user to for completing payment. |

**Example Response:**

``` json
{
  "paymentToken": "<jwt_token>",
  "paymentId": 6,
  "paymobOrderId": "488059542",
  "merchantOrderId": "MOR-20260316-88cb6e2ea97b4056b5b",
  "paymentUrl": "https://accept.paymob.com/api/acceptance/..."
}

 ```

---

### Notes

- The `paymentUrl` should be used to redirect the end user to the Paymob-hosted payment page.
    
- After the user completes or cancels payment, Paymob will send a callback to the webhook endpoint.
    
- The `violationIds` must belong to the authenticated citizen.

**Body (raw):**
```json
{
"ServiceRequestNumber": "VR-200"
}
```

### GET http://morourak.runasp.net/api/v1/Payment/status/MOR-20260324-b9e35a22a73d48b49bd

**Name:** Payment Status

## Payment Status

Retrieves the current payment status for a specific merchant order. Use this endpoint to check whether a payment has been completed, is pending, or has failed.

---

### HTTP Method & URL

```
GET {{baseUrl}}/api/Payment/status/{merchantOrderId}
```

---

### Authentication

This endpoint requires a **Bearer Token** in the `Authorization` header.

```
Authorization: Bearer <your_token>
```

---

### Path Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `merchantOrderId` | `string` | Yes | The unique merchant order ID associated with the payment (e.g., `MOR-20260316-88cb6e2ea97b4056b5b`) |

---

### Request Body

None — this is a `GET` request with no request body.

---

### Sample Response

**Status:** `200 OK`

```json
{
  "status": "Paid",
  "merchantOrderId": "MOR-20260316-88cb6e2ea97b4056b5b"
}
```

---

### Response Fields

| Field | Type | Description |
|---|---|---|
| `status` | `string` | The current payment status. Possible values include `Paid`, `Pending`, `Failed`, etc. |
| `merchantOrderId` | `string` | The merchant order ID that was queried, echoed back in the response for confirmation |

### GET http://morourak.runasp.net/api/v1/Payment/receipt/MOR-20260323-86083afdfa164055a53

**Name:** Get Receipt

### GET http://morourak.runasp.net/api/v1/payment/callback?success=true&merchant_order_id=MOR-20260325-a535120b063d4c7f94f

**Name:** Paymob Callback / Webhook

## Paymob Callback / Webhook

This endpoint receives payment status notifications (callbacks/webhooks) sent by **Paymob** after a payment transaction is processed. It is used to update the internal order and payment records based on the outcome of the payment.

---

### Authentication

This endpoint uses **HMAC signature verification** to ensure the request originates from Paymob.

| Header | Value | Description |
|--------|-------|-------------|
| `HMAC` | `<hmac_signature>` | HMAC hash generated by Paymob to verify the authenticity of the callback payload. |

> **Note:** The HMAC value should be validated server-side against the expected hash computed from the callback payload using the shared secret key.

---

### Request Body

The request body is a JSON object containing the payment transaction details.

```json
{
  "obj": {
    "paymentId": 6,
    "success": true,
    "order": {
      "paymobOrderId": "488059542",
      "merchantOrderId": "MOR-20260316-88cb6e2ea97b4056b5b"
    }
  }
}
```

#### Fields

| Field | Type | Description |
|-------|------|-------------|
| `obj` | `object` | Root object containing the payment transaction data. |
| `obj.paymentId` | `integer` | The internal payment ID associated with this transaction. |
| `obj.success` | `boolean` | Indicates whether the payment was successful (`true`) or failed (`false`). |
| `obj.order` | `object` | Order details linked to this payment. |
| `obj.order.paymobOrderId` | `string` | The order ID assigned by Paymob. |
| `obj.order.merchantOrderId` | `string` | The merchant's internal order reference ID. |

---

### Behavior

- If `success` is `true`, the server marks the associated order as **paid** and updates the payment record accordingly.
- If `success` is `false`, the server marks the payment as **failed** and may trigger retry or notification logic.
- The HMAC header is validated before processing the payload to prevent spoofed callbacks.

---

### Notes

- This endpoint is intended to be called by **Paymob's servers only**, not by the client application directly.
- Ensure the ngrok (or production) URL is registered as the callback URL in the Paymob dashboard.
- The `merchantOrderId` follows the format `MOR-{date}-{uniqueHash}`.

## Service Requests

### GET http://morourak.runasp.net/api/v1/servicerequests/my-requests

**Name:** Get My Requests

## Get My Requests

Retrieves all service requests submitted by the currently authenticated citizen. Returns a list of request objects, each containing status, fees, delivery, and payment details.

---

## Authentication

This endpoint requires a **Bearer Token** in the `Authorization` header.

```
Authorization: Bearer {{token}}
```

> Obtain the token by logging in through the Login endpoint and storing the returned JWT.

---

## Request Details

| Property      | Value                                          |
|---------------|------------------------------------------------|
| **Method**    | `GET`                                          |
| **URL**       | `{{baseUrl}}/api/service-requests/my-requests` |
| **Body**      | None                                           |
| **Query Params** | None                                        |

> `{{baseUrl}}` is resolved from the active environment — currently **Morourak Local**.

---

## Response

### 200 OK

Returns an array of service request objects belonging to the authenticated citizen.

**Example Response:**

```json
[
  {
    "requestNumber": "DR-800",
    "citizenNationalId": "29902012345678",
    "serviceType": "تجديد رخصة قيادة",
    "status": "قيد الانتظار",
    "submittedAt": "2026-03-08T22:42:15.6665072",
    "lastUpdatedAt": "2026-03-08T22:42:15.6665513",
    "referenceId": 1,
    "fees": {
      "baseFee": 0,
      "deliveryFee": 0,
      "totalAmount": 0
    },
    "delivery": {
      "method": null,
      "address": null
    },
    "payment": {
      "status": "قيد الانتظار",
      "transactionId": null,
      "amount": null,
      "timestamp": null
    }
  }
]
```

**Response Fields:**

| Field | Type | Description |
|---|---|---|
| `requestNumber` | `string` | Unique identifier for the service request (e.g. `DR-800`) |
| `citizenNationalId` | `string` | National ID of the citizen who submitted the request |
| `serviceType` | `string` | Type of service requested (e.g. driver's license renewal) |
| `status` | `string` | Current status of the request (e.g. `قيد الانتظار` = Pending) |
| `submittedAt` | `string (ISO 8601)` | Timestamp when the request was submitted |
| `lastUpdatedAt` | `string (ISO 8601)` | Timestamp of the most recent update to the request |
| `referenceId` | `integer` | Internal reference ID for the request |
| `fees.baseFee` | `number` | Base service fee amount |
| `fees.deliveryFee` | `number` | Delivery fee amount |
| `fees.totalAmount` | `number` | Total fees charged for the request |
| `delivery.method` | `string \| null` | Delivery method selected (null if not yet set) |
| `delivery.address` | `string \| null` | Delivery address (null if not yet set) |
| `payment.status` | `string` | Payment status (e.g. `قيد الانتظار` = Pending) |
| `payment.transactionId` | `string \| null` | Payment transaction ID (null if not yet paid) |
| `payment.amount` | `number \| null` | Amount paid (null if not yet paid) |
| `payment.timestamp` | `string \| null` | Timestamp of payment (null if not yet paid) |

---

## Environment Variables

| Variable | Source | Description |
|---|---|---|
| `{{baseUrl}}` | Morourak Local (active environment) | Base URL for all API requests |

### GET http://morourak.runasp.net/api/v1/service-requests/:requestNumber

**Name:** Get Request Details

## Staff

### GET http://morourak.runasp.net/api/v1/staff/examinations

**Name:** Get Appointments For Logged-in Staff

## Get Appointments For Logged-in Staff

Retrieves all medical examination appointments assigned to the currently authenticated staff member. The response includes detailed information about each appointment such as the citizen's national ID, appointment timing, status, and the associated traffic unit and governorate.

---

### Authentication

This endpoint requires a **Bearer JWT token** in the `Authorization` header.

```
Authorization: Bearer {{token}}
```

---

### Response Fields — `data` Array

| Field | Type | Description |
|---|---|---|
| `citizenNationalId` | string | The national ID of the citizen associated with the appointment |
| `applicationId` | integer | Unique identifier of the application linked to the appointment |
| `type` | string | Internal type code of the examination (e.g., `كشف طبي`) |
| `typeName` | string | Display name of the examination type |
| `serviceName` | string | Name of the service being provided |
| `date` | string (date) | Appointment date in `YYYY-MM-DD` format |
| `dateFormatted` | string | Human-readable appointment date (Arabic format) |
| `startTime` | string | Appointment start time in `HH:mm` format |
| `timeFormatted` | string | Human-readable start time (Arabic format, e.g., `09:30 صباحاً`) |
| `endTime` | string | Appointment end time in `HH:mm` format |
| `status` | string | Current status of the appointment (e.g., `محجوز` = Booked) |
| `createdAt` | string | Timestamp when the appointment was created (Arabic format) |
| `completedAt` | string | Timestamp when the appointment was completed, or `غير مكتمل` if not yet completed |
| `requestNumberRelated` | string | Reference number of the related request (e.g., `DR-800`) |
| `assignedToUserId` | string | ID of the staff member assigned to the appointment (e.g., `DOCTOR`) |
| `governorateName` | string | Name of the governorate where the appointment takes place |
| `trafficUnitName` | string | Name of the traffic unit associated with the appointment |

---

### Sample Success Response — `200 OK`

```json
{
  "isSuccess": true,
  "count": 1,
  "data": [
    {
      "citizenNationalId": "29902012345678",
      "applicationId": 1,
      "type": "كشف طبي",
      "typeName": "كشف طبي",
      "serviceName": "كشف طبي",
      "date": "2026-03-14",
      "dateFormatted": "14 مارس 2026",
      "startTime": "09:30",
      "timeFormatted": "09:30 صباحاً",
      "endTime": "10:00",
      "status": "محجوز",
      "createdAt": "16 مارس 2026 11:44 م",
      "completedAt": "غير مكتمل",
      "requestNumberRelated": "DR-800",
      "assignedToUserId": "DOCTOR",
      "governorateName": "القاهرة",
      "trafficUnitName": "مرور وسط القاهرة"
    }
  ]
}
```

### POST http://morourak.runasp.net/api/v1/staff/submit

**Name:** Submit Examination Result

## Submit Examination Result

Submits the result of a vehicle/driving examination conducted by an inspector. This endpoint allows staff members with the **INSPECTOR** role to record whether a citizen passed or failed their examination for a given service request.

---

### Authentication

Requires a valid **Bearer Token** in the `Authorization` header. The token must belong to a user with the `INSPECTOR` role.

```
Authorization: Bearer {{token}}
```

---

### Request Body

Content-Type: `application/json`

| Field | Type | Required | Description |
|---|---|---|---|
| `RequestNumber` | string | ✅ Yes | The unique identifier of the service request (e.g. `VR-202`, `DR-800`) |
| `passed` | boolean | ✅ Yes | `true` if the citizen passed the examination, `false` otherwise |

**Example:**
```json
{
    "RequestNumber": "VR-202",
    "passed": true
}
```

---

### Responses

| Status | Description |
|---|---|
| `200 OK` | Examination result submitted successfully |
| `400 Bad Request` | Invalid request body or request number not found |
| `401 Unauthorized` | Missing or invalid Bearer token |
| `403 Forbidden` | Authenticated user does not have the INSPECTOR role |

---

### Notes

- The `{{baseUrl}}` variable is defined in the **Morourak Local** environment.
- Ensure the `RequestNumber` corresponds to an existing, active service request before submitting.


**Body (raw):**
```json
{
    "RequestNumber": "DL-500",
    "passed": true
}
```

## Admin

### Data Management

### GET http://morourak.runasp.net/api/v1/AdminSeedData/citizens

**Name:** Get Citizens

### GET http://morourak.runasp.net/api/v1/AdminSeedData/vehicle-licenses

**Name:** Get Vehicle-Licenses

### GET http://morourak.runasp.net/api/v1/AdminSeedData/driving-licenses

**Name:** Get Driving-Licenses

### Users Management

### GET http://morourak.runasp.net/api/v1/adminusers

**Name:** Get Users

### POST http://morourak.runasp.net/api/v1/adminusers

**Name:** Create User

**Body (raw):**
```json
{
  "email": "user011@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "role": "Citizen",
  "password": "StrongPassword123!"
}
```

### PUT http://morourak.runasp.net/api/v1/adminusers/{id}

**Name:** Update User

**Body (raw):**
```json
{
  "firstName": "Jane",
  "lastName": "Doe",
  "role": "Admin",
  "email": "newemail@example.com"
}
```

### DELETE http://morourak.runasp.net/api/v1/adminusers/2d5dc7e8-a5cc-4d56-97f3-3efa58cc4fd9

**Name:** Delete User

