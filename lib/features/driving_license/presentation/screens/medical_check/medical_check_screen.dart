import 'package:flutter/material.dart';
import 'package:traffic/core/widgets/generic_booking_screen.dart';
import 'package:traffic/features/driving_license/presentation/screens/medical_check/appointment_booking_screen.dart';

// ── Dummy data ─────────────────────────────────────────────────────────────────

const List<String> _kMedicalCenters = [
  'مستشفي المدينة الدولي',
  'مستشفي السلام',
  'مستشفى الشرطة',
  'المركز الطبي العربي',
  'مستشفى النيل للتأمين الصحي',
];

// ── Screen ─────────────────────────────────────────────────────────────────────

/// **Medical Check Screen** — thin wrapper around [GenericBookingScreen].
///
/// Injects medical-check-specific labels and delegates "التالي" to the
/// caller-provided [onNextPressed].
class MedicalCheckScreen extends StatelessWidget {
  /// The app bar title for this screen (e.g. "اصدار رخصة قيادة").
  final String appBarTitle;

  /// Callback invoked when the user taps the active "التالي" button.
  final VoidCallback onNextPressed;
  final Future<List<BookingSelectionOption>> Function()? loadGovernorates;
  final Future<List<BookingSelectionOption>> Function(String governorateId)?
      loadMedicalCenters;
  final Future<List<String>> Function(DateTime selectedDate)? loadSlotsForDate;
  final Future<AppointmentBookingMeta?> Function(
    String governorateId,
    String secondaryId,
    DateTime selectedDate,
    String selectedSlot,
  )? submitAppointmentBooking;

  const MedicalCheckScreen({
    super.key,
    required this.appBarTitle,
    required this.onNextPressed,
    this.loadGovernorates,
    this.loadMedicalCenters,
    this.loadSlotsForDate,
    this.submitAppointmentBooking,
  });

  @override
  Widget build(BuildContext context) {
    return GenericBookingScreen(
      appBarTitle: appBarTitle,
      headerTitle: 'الكشف الطبي',
      bookingCardTitle: 'حجز موعد الكشف الطبي',
      appointmentCardTitle: 'موعد الكشف الطبي',
      secondaryDropdown: const SecondaryDropdownConfig(
        label: 'مركز طبي',
        hint: 'اختر مركز طبي',
        sheetTitle: 'اختر مركز طبي',
        items: _kMedicalCenters,
      ),
      loadGovernorates: loadGovernorates,
      loadSecondaryOptions: loadMedicalCenters,
      loadSlotsForDate: loadSlotsForDate,
      submitAppointmentBooking: submitAppointmentBooking,
      onNextPressed: onNextPressed,
    );
  }
}
