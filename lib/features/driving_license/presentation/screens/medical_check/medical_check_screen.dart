import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/appointment_details_card.dart';
import 'package:traffic/core/widgets/custom_dropdown_field.dart';
import 'package:traffic/core/widgets/generic_list_bottom_sheet.dart';
import 'package:traffic/core/widgets/medical_center_info_card.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/auth/presentation/screens/signup_screen/widgets/signup_step1_form/widgets/next_button_widget.dart';
import 'appointment_booking_screen.dart';

// ── Dummy data ─────────────────────────────────────────────────────────────────

const List<String> _kGovernorates = [
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

const List<String> _kMedicalCenters = [
  'مستشفي المدينة الدولي',
  'مستشفي السلام',
  'مستشفى الشرطة',
  'المركز الطبي العربي',
  'مستشفى النيل للتأمين الصحي',
];

// ── Screen ─────────────────────────────────────────────────────────────────────

/// Medical check screen — step in the "إصدار رخصة قيادة" flow.
///
/// **States:**
/// - Before booking (`isBooked == false`): shows dropdown fields and
///   a "حجز الموعد" button.
/// - After booking (`isBooked == true`): shows the same dropdowns (read-only
///   feel), a "تم الحجز" success indicator, a [MedicalCenterInfoCard], and an
///   [AppointmentDetailsCard].
///
/// Replace local state with a Cubit when scaling up.
class MedicalCheckScreen extends StatefulWidget {
  const MedicalCheckScreen({super.key});

  @override
  State<MedicalCheckScreen> createState() => _MedicalCheckScreenState();
}

class _MedicalCheckScreenState extends State<MedicalCheckScreen> {
  // ── State ──────────────────────────────────────────────────────────────────

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedGovernorate;
  String? _selectedMedicalCenter;

  /// Set to `true` once the user confirms an appointment.
  bool _isBooked = false;

  /// The booking result returned from [AppointmentBookingScreen].
  AppointmentResult? _bookingResult;

  /// "التالي" is active when both fields are selected AND a booking was made.
  bool get _canProceed =>
      _selectedGovernorate != null &&
      _selectedMedicalCenter != null &&
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
        items: _kGovernorates,
        onItemSelected: (value) {
          setState(() {
            _selectedGovernorate = value;
            // Reset downstream selections when governorate changes
            _selectedMedicalCenter = null;
            _isBooked = false;
            _bookingResult = null;
          });
        },
      ),
    );
  }

  void _showMedicalCenterSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (_) => GenericListBottomSheet(
        title: 'اختر مركز طبي',
        items: _kMedicalCenters,
        onItemSelected: (value) {
          setState(() {
            _selectedMedicalCenter = value;
            // Reset booking when centre changes
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
      MaterialPageRoute(builder: (_) => const AppointmentBookingScreen()),
    );
    if (result != null && mounted) {
      setState(() {
        _isBooked = true;
        _bookingResult = result;
      });
    }
  }

  void _onNextPressed() {
    // TODO(cubit): navigate to the next step in the flow.
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Formats [AppointmentResult.selectedDate] as a human-readable Arabic string.
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

  /// Extracts a presentable time string from a slot like "09:00-10:00 Am".
  String _formatTime(String slot) {
    // Return the start time with the period, e.g. "09:00 صباحا"
    final parts = slot.split('-');
    if (parts.isEmpty) return slot;
    final timePart = parts.first.trim();
    final period = slot.toLowerCase().contains('pm') ? 'مساءا' : 'صباحا';
    return '$timePart $period';
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // ── App bar ──────────────────────────────────────────────────────
          ServiceScreenAppBar(
            title: 'اصدار رخصة قيادة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),

          // ── Scrollable body ──────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),

                  // ── Section title ──────────────────────────────────────
                  Text(
                    'الكشف الطبي',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Governorate picker ─────────────────────────────────
                  CustomDropdownField(
                    label: 'المحافظة',
                    hint: 'اختر محافظتك',
                    value: _selectedGovernorate,
                    onTap: _showGovernorateSheet,
                  ),
                  SizedBox(height: 16.h),

                  // ── Medical centre picker ──────────────────────────────
                  CustomDropdownField(
                    label: 'مركز طبي',
                    hint: 'اختر مركز طبي',
                    value: _selectedMedicalCenter,
                    onTap: _showMedicalCenterSheet,
                  ),
                  SizedBox(height: 16.h),

                  // ── Booking card ──────────────────────────────────────
                  _BookingCard(
                    isBooked: _isBooked,
                    onBookPressed: _onBookAppointmentPressed,
                  ),

                  // ── Post-booking info (conditional) ───────────────────
                  if (_isBooked && _bookingResult != null) ...[
                    SizedBox(height: 16.h),
                    MedicalCenterInfoCard(
                      centerName: _selectedMedicalCenter ?? '',
                      address:
                          'شارع التسعين , العاشر من رمضان , ${_selectedGovernorate ?? ''}',
                      workingHours: '9 ص الي 3 م (الاحد -الخميس)',
                    ),
                    SizedBox(height: 16.h),
                    AppointmentDetailsCard(
                      date: _formatDate(_bookingResult!.selectedDate),
                      time: _formatTime(_bookingResult!.selectedSlot),
                      bookingNumber: '10',
                    ),
                  ],

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // ── Bottom action ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
            child: NextButtonWidget(
              onPressed: _onNextPressed,
              isValid: _canProceed,
              height: 48.h,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widget: booking card
// ─────────────────────────────────────────────────────────────────────────────

/// Shows either "حجز الموعد" button or "تم الحجز" success state.
class _BookingCard extends StatelessWidget {
  final bool isBooked;
  final VoidCallback onBookPressed;

  const _BookingCard({required this.isBooked, required this.onBookPressed});

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
          // ── Card title ─────────────────────────────────────────────────
          Text(
            'حجز موعد الكشف الطبي',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color(0xFF222222),
              fontSize: 15.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),

          // ── Action: conditional ────────────────────────────────────────
          if (isBooked)
            // ── Success state: "تم الحجز" ───────────────────────────────
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
            // ── Default state: book button ───────────────────────────────
            InkWell(
              onTap: onBookPressed,
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
