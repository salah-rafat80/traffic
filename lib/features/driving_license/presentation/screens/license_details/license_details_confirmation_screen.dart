import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/auth/presentation/screens/signup_screen/widgets/signup_step1_form/widgets/next_button_widget.dart';
import 'package:traffic/features/driving_license/presentation/screens/theory_test/theory_test_booking_screen.dart';
import 'package:traffic/features/violations_inquiry/data/models/license_model.dart';
import 'widgets/license_info_card.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

/// **Selected Licence Confirmation Screen** — the user reviews the details of
/// the licence they have selected to renew before proceeding.
///
/// This screen is part of the "License Renewal Flow". It receives the already-
/// selected [DrivingLicenseModel] and renders it in a read-only, confirmed
/// state (green border, selected radio dot). The "التالي" button navigates to
/// [TheoryTestBookingScreen].
class LicenseDetailsConfirmationScreen extends StatelessWidget {
  /// The licence chosen by the user on the previous screen.
  final DrivingLicenseModel license;

  const LicenseDetailsConfirmationScreen({
    super.key,
    required this.license,
  });

  // ── Handlers ────────────────────────────────────────────────────────────────

  void _onNextPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TheoryTestBookingScreen(),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // ── App bar ──────────────────────────────────────────────────────
            ServiceScreenAppBar(
              title: 'تجديد رخصة القيادة',
            ),

            // ── Scrollable body ──────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Section header ────────────────────────────────────────
                    Text(
                      'تفاصيل رخصة القيادة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF222222),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // ── Confirmed licence card ────────────────────────────────
                    // Wrapped in a green-bordered container to match the
                    // "selected" state shown in the design.
                    _ConfirmedLicenseCard(data: license),

                    SizedBox(height: 24.h),

                    // ── Primary action button ─────────────────────────────────
                    NextButtonWidget(
                      onPressed: () => _onNextPressed(context),
                      isValid: true,
                      height: 48.h,
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widget ────────────────────────────────────────────────────────

/// Renders [LicenseInfoCard] inside a green selected border, mimicking the
/// visual state of a confirmed / selected licence without any tap interactions.
class _ConfirmedLicenseCard extends StatelessWidget {
  final DrivingLicenseModel data;

  const _ConfirmedLicenseCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFF27AE60),
          width: 2.w,
        ),
      ),
      child: LicenseInfoCard(
        data: data,
        // Pass isSelected: true so the RadioDot renders as filled green
        // and LicenseStatusBadge uses the correct valid colour.
        isSelected: true,
      ),
    );
  }
}

