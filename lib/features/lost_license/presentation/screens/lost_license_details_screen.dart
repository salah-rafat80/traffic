import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/driving_license/presentation/screens/license_details/widgets/license_info_card.dart';
import 'package:traffic/features/driving_license/data/models/driving_license_model.dart';
import 'replacement_type_selection_screen.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

/// **Lost / Damaged Licence — Confirmation Screen** (Step 2)
///
/// The user reviews the details of the licence they have selected for
/// replacement. The card is displayed in a confirmed (green-bordered, selected)
/// state. This screen is part of the "Lost/Damaged Driving License Replacement"
/// flow.
class LostLicenseDetailsScreen extends StatelessWidget {
  /// The licence chosen by the user on the previous screen.
  final DrivingLicenseModel license;

  const LostLicenseDetailsScreen({super.key, required this.license});

  // ── Handlers ────────────────────────────────────────────────────────────────

  void _onNextPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReplacementTypeSelectionScreen(license: license),
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
            const ServiceScreenAppBar(title: 'استخراج بدل فاقد / تالف'),

            // ── Scrollable body ──────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                    // Green-bordered container replicates the "selected" visual
                    // state to confirm the user's choice.
                    _ConfirmedLicenseCard(data: license),

                    SizedBox(height: 24.h),

                    // ── Primary action button ─────────────────────────────────
                    PrimaryButton(
                      label: 'التالي',
                      onPressed: () => _onNextPressed(context),
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
        border: Border.all(color: const Color(0xFF27AE60), width: 2.w),
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
