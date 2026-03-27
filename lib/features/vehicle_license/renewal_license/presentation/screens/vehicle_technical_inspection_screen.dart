import 'package:flutter/material.dart';
import 'package:traffic/core/widgets/generic_booking_screen.dart';
import 'package:traffic/core/features/checkout/generic_order_review_screen.dart';
import 'package:traffic/core/features/checkout/models/applicant_details.dart';
import 'package:traffic/core/features/checkout/models/fees_details.dart';
import 'package:traffic/core/features/checkout/models/order_summary.dart';
import '../../data/models/renewal_vehicle_license_model.dart';

// ── Dummy data ─────────────────────────────────────────────────────────────────

const List<String> _kTrafficUnits = [
  'العاشر من رمضان',
  'وحدة مرور مدينة نصر',
  'وحدة مرور المعادي',
  'وحدة مرور الهرم',
  'وحدة مرور شبرا',
  'وحدة مرور المقطم',
];

// ── Screen ─────────────────────────────────────────────────────────────────────

/// **Vehicle Technical Inspection Booking Screen** — thin wrapper around
/// [GenericBookingScreen].
///
/// Uses the same UI as the driving-license renewal booking flow, but with
/// vehicle-inspection-specific labels.
class VehicleTechnicalInspectionScreen extends StatelessWidget {
  final RenewalVehicleLicenseModel vehicle;

  const VehicleTechnicalInspectionScreen({super.key, required this.vehicle});

  void _onNextPressed(BuildContext context) {
    const applicant = ApplicantDetails(
      name: 'اميرة عصام حامد',
      nationalId: '010123456789099',
      phone: '01013706488',
      email: 'amirabadreldeen7@icloud.com',
    );
    final orderSummary = OrderSummary(
      orderType: 'تجديد رخصة مركبة',
      paymentMethod: 'الدفع إلكترونيًا',
      orderId: vehicle.plateNumber,
    );
    const fees = FeesDetails(
      items: [
        FeeItem(label: 'رسوم تجديد الرخصة', amount: '200 جنيه مصري'),
        FeeItem(label: 'رسوم الفحص الفني', amount: '80 جنيه مصري'),
      ],
      total: '280 جنيه مصري',
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GenericOrderReviewScreen(
          appBarTitle: 'تجديد رخصة مركبة',
          applicantDetails: applicant,
          orderSummary: orderSummary,
          feesDetails: fees,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GenericBookingScreen(
      appBarTitle: 'تجديد رخصة مركبة',
      headerTitle: 'الفحص الفني للمركبة',
      bookingCardTitle: 'حجز موعد الفحص الفني',
      appointmentCardTitle: 'موعد الفحص الفني',
      secondaryDropdown: const SecondaryDropdownConfig(
        label: 'وحدة المرور',
        hint: 'اختر وحدة المرور',
        sheetTitle: 'اختر وحدة المرور',
        items: _kTrafficUnits,
      ),
      onNextPressed: () => _onNextPressed(context),
    );
  }
}
