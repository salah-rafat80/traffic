import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traffic/features/violations_inquiry/data/models/license_model.dart';

/// Card widget that displays driving license details with a radio selection.
/// Matches the design: bordered card with green radio, license number chip,
/// and detail rows (RTL layout).
class LicenseDetailsCard extends StatelessWidget {
  final DrivingLicenseModel license;
  final bool isSelected;
  final VoidCallback onTap;

  const LicenseDetailsCard({
    super.key,
    required this.license,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2E7D32)
                : const Color(0xFFE8E8E8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ── Radio button ──
            Align(
              alignment: Alignment.centerLeft,
              child: _RadioDot(isSelected: isSelected),
            ),
            SizedBox(height: 12.h),

            // ── License number row ──
            _DetailRow(
              label: 'رقم الرخصة',
              value: '',
              customValue: _LicenseNumberChip(number: license.licenseNumber),
            ),
            SizedBox(height: 6.h),
            Divider(),

            // ── Type ──
            _DetailRow(label: 'نوع الرخصة', value: license.type),
            SizedBox(height: 6.h),
            Divider(),
            // ── Governorate ──
            _DetailRow(label: 'المحافظة', value: license.governorate),
            SizedBox(height: 6.h),
            Divider(),
            // ── Licensing unit ──
            _DetailRow(label: 'وحدة الترخيص', value: license.licensingUnit),
            SizedBox(height: 6.h),
            Divider(),
            // ── Status ──
            _DetailRow(
              label: 'حالة الرخصة',
              value: '',
              customValue: _StatusChip(status: license.status),
            ),
            SizedBox(height: 6.h),
            Divider(),
            // ── Issue date ──
            _DetailRow(label: 'تاريخ الاصدار', value: license.issueDate),
            SizedBox(height: 6.h),
            Divider(),
            // ── Expiry date ──
            _DetailRow(label: 'تاريخ الانتهاء', value: license.expiryDate),
          ],
        ),
      ),
    );
  }
}

// ── Radio dot indicator ──────────────────────────────────────────────────────

class _RadioDot extends StatelessWidget {
  final bool isSelected;
  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? const Color(0xFF27AE60) : const Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF27AE60),
                ),
              ),
            )
          : null,
    );
  }
}

// ── License number chip ──────────────────────────────────────────────────────

class _LicenseNumberChip extends StatelessWidget {
  final String number;
  const _LicenseNumberChip({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF27AE60),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ── Status chip ──────────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'سارية';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF2E7D32).withValues(alpha: 0.1)
            : const Color(0xFFD32F2F).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isActive ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F),
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isActive ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F),
        ),
      ),
    );
  }
}

// ── Detail row ───────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? customValue;

  const _DetailRow({
    required this.label,
    required this.value,
    this.customValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        customValue ??
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF555555),
              ),
            ),
      ],
    );
  }
}
