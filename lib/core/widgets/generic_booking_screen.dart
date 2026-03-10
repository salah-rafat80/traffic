import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/appointment_details_card.dart';
import 'package:traffic/core/widgets/custom_dropdown_field.dart';
import 'package:traffic/core/widgets/generic_list_bottom_sheet.dart';
import 'package:traffic/core/widgets/medical_center_info_card.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/driving_license/presentation/screens/medical_check/appointment_booking_screen.dart';

// ── Dummy data ─────────────────────────────────────────────────────────────────

const List<String> kDefaultGovernorates = [
  'القاهرة',
  'الاسكندرية',
  'الشرقية',
  'دمياط',
  'الغربية',
  'الدقهلية',
  'الإسماعيلية',
  'السويس',
  'بورسعيد',
  'المنوفية',
];

// ── Configuration model ────────────────────────────────────────────────────────

/// Holds the labels, hints, and items for the second dropdown field.
///
/// The first dropdown is always "المحافظة"; the second varies per use-case
/// (e.g. "وحدة المرور" or "مركز طبي").
@immutable
class SecondaryDropdownConfig {
  /// Label shown above the dropdown (e.g. "وحدة المرور").
  final String label;

  /// Placeholder text inside the dropdown (e.g. "اختر وحدة المرور").
  final String hint;

  /// Bottom-sheet title shown when the dropdown opens.
  final String sheetTitle;

  /// The list of selectable items.
  final List<String> items;

  const SecondaryDropdownConfig({
    required this.label,
    required this.hint,
    required this.sheetTitle,
    required this.items,
  });
}

// ── Screen ─────────────────────────────────────────────────────────────────────

/// **GenericBookingScreen** — a fully reusable booking template.
///
/// All text labels and the final "التالي" action are injected via the
/// constructor so the widget contains **zero** business-flow knowledge.
///
/// ### Parameters
/// | param | purpose |
/// |---|---|
/// | [appBarTitle] | Title displayed in [ServiceScreenAppBar]. |
/// | [headerTitle] | Section heading below the app bar. |
/// | [bookingCardTitle] | Bold title inside the booking card. |
/// | [secondaryDropdown] | Config for the second dropdown (label, hint, items). |
/// | [appointmentCardTitle] | Title of the [AppointmentDetailsCard] after booking. |
/// | [onNextPressed] | Callback fired when the user taps the active "التالي" button. |
///
/// ### Internal state
/// * `_isBooked` — flips to `true` after the calendar returns a result.
/// * `_canProceed` — both dropdowns selected **and** `_isBooked == true`.
///
/// Replace local state with a Cubit when scaling up.
class GenericBookingScreen extends StatefulWidget {
  /// Title shown in the [ServiceScreenAppBar].
  final String appBarTitle;

  /// Section heading rendered below the app bar (e.g. "الكشف الطبي").
  final String headerTitle;

  /// Bold title inside the booking card (e.g. "حجز موعد الكشف الطبي").
  final String bookingCardTitle;

  /// Configuration for the second dropdown field.
  final SecondaryDropdownConfig secondaryDropdown;

  /// Title of the [AppointmentDetailsCard] shown after booking.
  /// Defaults to `'موعد الكشف الطبي'` if omitted.
  final String? appointmentCardTitle;

  /// Callback invoked when the user taps "التالي" **after** a successful
  /// booking. The widget guarantees this is only called when
  /// `_canProceed == true`.
  final VoidCallback onNextPressed;

  const GenericBookingScreen({
    super.key,
    required this.appBarTitle,
    required this.headerTitle,
    required this.bookingCardTitle,
    required this.secondaryDropdown,
    this.appointmentCardTitle,
    required this.onNextPressed,
  });

  @override
  State<GenericBookingScreen> createState() => _GenericBookingScreenState();
}

class _GenericBookingScreenState extends State<GenericBookingScreen> {
  // ── State ──────────────────────────────────────────────────────────────────

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedGovernorate;
  String? _selectedSecondary;

  /// Set to `true` once the user confirms an appointment.
  bool _isBooked = false;

  /// The booking result returned from [AppointmentBookingScreen].
  AppointmentResult? _bookingResult;

  /// "التالي" is active only when both fields are selected AND a booking exists.
  bool get _canProceed =>
      _selectedGovernorate != null &&
      _selectedSecondary != null &&
      _isBooked;

  // ── Handlers ──────────────────────────────────────────────────────────────

  void _showGovernorateSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (_) => GenericListBottomSheet(
        title: 'اختر محافظتك',
        items: kDefaultGovernorates,
        onItemSelected: (value) {
          setState(() {
            _selectedGovernorate = value;
            // Reset downstream when governorate changes
            _selectedSecondary = null;
            _isBooked = false;
            _bookingResult = null;
          });
        },
      ),
    );
  }

  void _showSecondarySheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (_) => GenericListBottomSheet(
        title: widget.secondaryDropdown.sheetTitle,
        items: widget.secondaryDropdown.items,
        onItemSelected: (value) {
          setState(() {
            _selectedSecondary = value;
            // Reset booking when secondary selection changes
            _isBooked = false;
            _bookingResult = null;
          });
        },
      ),
    );
  }

  Future<void> _onBookAppointmentPressed() async {
    final result = await Navigator.push<AppointmentResult>(
      context,
      MaterialPageRoute(
        builder: (_) => AppointmentBookingScreen(
          appBarTitle: widget.appBarTitle,
          bookingHeaderTitle: widget.bookingCardTitle,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _isBooked = true;
        _bookingResult = result;
      });
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _formatDate(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'ابريل',
      'مايو',
      'يونيو',
      'يوليو',
      'اغسطس',
      'سبتمبر',
      'اكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(String slot) {
    final parts = slot.split('-');
    if (parts.isEmpty) return slot;
    final timePart = parts.first.trim();
    final period = slot.toLowerCase().contains('pm') ? 'مساءا' : 'صباحا';
    return '$timePart $period';
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF5F5F5),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            // ── App bar ────────────────────────────────────────────────────
            ServiceScreenAppBar(
              title: widget.appBarTitle,
              onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),

            // ── Scrollable body ────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.h),

                    // ── Section title ────────────────────────────────────
                    Text(
                      widget.headerTitle,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFF222222),
                        fontSize: 17.sp,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Governorate picker ───────────────────────────────
                    CustomDropdownField(
                      label: 'المحافظة',
                      hint: 'اختر محافظتك',
                      value: _selectedGovernorate,
                      onTap: _showGovernorateSheet,
                    ),
                    SizedBox(height: 16.h),

                    // ── Secondary picker (traffic unit / medical centre) ─
                    CustomDropdownField(
                      label: widget.secondaryDropdown.label,
                      hint: widget.secondaryDropdown.hint,
                      value: _selectedSecondary,
                      onTap: _showSecondarySheet,
                    ),
                    SizedBox(height: 16.h),

                    // ── Booking card ─────────────────────────────────────
                    _BookingCard(
                      title: widget.bookingCardTitle,
                      isBooked: _isBooked,
                      onBookPressed: _onBookAppointmentPressed,
                    ),

                    // ── Post-booking info (conditional) ──────────────────
                    if (_isBooked && _bookingResult != null) ...[
                      SizedBox(height: 16.h),

                      // Facility info card
                      MedicalCenterInfoCard(
                        centerName: _selectedSecondary ?? '',
                        address:
                            'شارع التسعين , ${_selectedSecondary ?? ''} , ${_selectedGovernorate ?? ''}',
                        workingHours: '9 ص الي 3 م (الاحد -الخميس)',
                      ),
                      SizedBox(height: 16.h),

                      // Booking summary card
                      AppointmentDetailsCard(
                        title: widget.appointmentCardTitle,
                        date: _formatDate(_bookingResult!.selectedDate),
                        time: _formatTime(_bookingResult!.selectedSlot),
                        bookingNumber: '10',
                        requestNumber: '13456670',
                      ),
                    ],

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // ── Bottom action ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: PrimaryButton(
                label: 'التالي',
                onPressed: _canProceed ? widget.onNextPressed : null,
                height: 48.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widget: booking card
// ─────────────────────────────────────────────────────────────────────────────

/// Shows either the active "حجز الموعد" button or the "تم الحجز" success state.
class _BookingCard extends StatelessWidget {
  final String title;
  final bool isBooked;
  final VoidCallback onBookPressed;

  const _BookingCard({
    required this.title,
    required this.isBooked,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFF27AE60)),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Card title ───────────────────────────────────────────────────
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF222222),
              fontSize: 15.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),

          // ── Action: conditional ──────────────────────────────────────────
          if (isBooked)
            // ── Success state ────────────────────────────────────────────
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                borderRadius: BorderRadius.circular(4.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'تم الحجز',
                style: TextStyle(
                  color: const Color(0xFFF5F5F5),
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            // ── Default state ────────────────────────────────────────────
            InkWell(
              onTap: onBookPressed,
              borderRadius: BorderRadius.circular(4.r),
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF27AE60),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'حجز الموعد',
                    style: TextStyle(
                      color: const Color(0xFFF5F5F5),
                      fontSize: 16.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

