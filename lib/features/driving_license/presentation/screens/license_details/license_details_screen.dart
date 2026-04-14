import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/auth/presentation/screens/signup_screen/widgets/signup_step1_form/widgets/next_button_widget.dart';
import 'package:traffic/features/driving_license/domain/enums/license_status.dart';
import 'package:traffic/features/driving_license/data/models/driving_license_model.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/violations_list_screen.dart';
import 'package:traffic/features/driving_license/data/repositories/driving_license_repository.dart';
import 'package:traffic/core/api/api_client.dart';
import 'license_details_confirmation_screen.dart';
import 'widgets/license_info_card.dart';
import 'widgets/warning_banner.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

/// **Licence Selection Screen** — shown after the user agrees to terms.
///
/// Lists all driving licences for the current user. The user selects the
/// licence they wish to renew. Selection rules:
///
/// | Status               | Selectable | "التالي" state                 |
/// |----------------------|------------|-------------------------------|
/// | valid                | ✅          | Active → proceeds to next step |
/// | expired, no violations | ✅        | Active → proceeds to next step |
/// | expired, with violations | ✅      | Disabled (pay violations first)|
/// | withdrawn            | ❌          | N/A — card is disabled        |
class LicenseDetailsScreen extends StatefulWidget {
  final Future<void> Function(DrivingLicenseModel selectedLicense)?
      onNextWithSelectedLicense;

  const LicenseDetailsScreen({
    super.key,
    this.onNextWithSelectedLicense,
  });

  @override
  State<LicenseDetailsScreen> createState() => _LicenseDetailsScreenState();
}

class _LicenseDetailsScreenState extends State<LicenseDetailsScreen> {
  /// List of licences loaded from the repository.
  List<DrivingLicenseModel> _licenses = [];
  bool _isLoading = true;
  bool _isSubmitting = false;

  /// Index of the currently selected licence, or `null` if none selected.
  int? _selectedIndex;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadLicenses();
  }

  Future<void> _loadLicenses() async {
    setState(() => _isLoading = true);
    try {
      final repository = DrivingLicenseRepository(ApiClient());
      var cachedLicenses = await repository.getLocalLicenses();
      
      // If cache is empty (e.g. after hot restart without fresh login), fetch from API
      if (cachedLicenses.isEmpty) {
        final result = await repository.getMyLicenses();
        if (result.isSuccess && result.data != null) {
          cachedLicenses = result.data!;
          await repository.saveLicensesLocal(cachedLicenses);
        }
      }

      setState(() {
        _licenses = cachedLicenses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  // ── Derived state ──────────────────────────────────────────────────────────

  DrivingLicenseModel? get _selectedLicense => _selectedIndex != null
      ? _licenses[_selectedIndex!]
      : null;

  /// The "التالي" button is active only when a licence is selected AND it has
  /// no unpaid violations (withdrawn licences cannot be selected at all).
  bool get _canProceed {
    final lic = _selectedLicense;
    if (lic == null) return false;
    return !lic.hasUnpaidViolations;
  }

  // ── Handlers ──────────────────────────────────────────────────────────────

  void _onCardTap(int index) {
    final lic = _licenses[index];
    if (lic.status == LicenseStatus.withdrawn) return; // not selectable
    setState(() => _selectedIndex = index);
  }

  Future<void> _onNextPressed() async {
    final lic = _selectedLicense;
    if (lic == null) return;
    if (_isSubmitting) return;

    final Future<void> Function(DrivingLicenseModel selectedLicense)?
        callback = widget.onNextWithSelectedLicense;
    if (callback != null) {
      setState(() => _isSubmitting = true);
      try {
        await callback(lic);
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LicenseDetailsConfirmationScreen(license: lic),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF5F5F5),
        drawer: const AppDrawer(),
        body: Stack(
          children: [
            Column(
              children: [
            // ── App bar ──────────────────────────────────────────────────────
            ServiceScreenAppBar(
              title: 'تجديد رخصة القيادة',
              onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),

            // ── Scrollable licence list ───────────────────────────────────────
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _licenses.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد رخص قيادة مسجلة',
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
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

                              // ── Licence cards ─────────────────────────────────────────
                              ..._licenses.asMap().entries.map((
                                entry,
                              ) {
                                final index = entry.key;
                                final lic = entry.value;
                                final bool isWithdrawn =
                                    lic.status == LicenseStatus.withdrawn;
                                final bool isSelected = _selectedIndex == index;

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _SelectableLicenseCard(
                                    data: lic,
                                    isSelected: isSelected,
                                    isDisabled: isWithdrawn,
                                    onTap: () => _onCardTap(index),
                                  ),
                                );
                              }),

                              SizedBox(height: 12.h),

                              // ── Primary action button ─────────────────────────────────
                              NextButtonWidget(
                                onPressed: () => _onNextPressed(),
                                isValid: _canProceed && !_isSubmitting,
                                height: 48.h,
                              ),

                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
            ),
              ],
            ),
            if (_isSubmitting)
              Positioned.fill(
                child: ColoredBox(
                  color: const Color(0x66000000),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


// ── Selectable card widget ────────────────────────────────────────────────────

/// A tappable wrapper around [LicenseInfoCard] that shows a selected border
/// and conditionally renders the [WarningBanner].
///
/// When [isDisabled] is `true` (withdrawn licence), the card is dimmed and
/// ignores taps.
class _SelectableLicenseCard extends StatelessWidget {
  final DrivingLicenseModel data;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const _SelectableLicenseCard({
    required this.data,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.45 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF27AE60)
                  : const Color(0xFFDADADA),
              width: isSelected ? 2.w : 1.w,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Info card ─────────────────────────────────────────────────
              LicenseInfoCard(data: data, isSelected: isSelected),

              // ── Warning banner (shown inside card when violations exist) ──
              if (isSelected && data.hasUnpaidViolations) ...[
                SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: WarningBanner(
                    license: data,
                    onViewViolationsTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViolationsListScreen(license: data),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
