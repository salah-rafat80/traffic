import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/Radio_dot.dart';
import 'package:traffic/features/driving_license/domain/enums/license_status.dart';
import 'package:traffic/features/driving_license/data/models/driving_license_model.dart';

/// A card widget that displays the full licence details in a clean, bordered
/// container. Matches the violations inquiry screen layout.
class LicenseInfoCard extends StatelessWidget {
  final DrivingLicenseModel data;
  final bool isSelected;

  const LicenseInfoCard({
    super.key,
    required this.data,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF27AE60)
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
            child: RadioDot(isSelected: isSelected),
          ),
          SizedBox(height: 12.h),

          // ── License number row ──
          _DetailRow(
            label: 'رقم الرخصة',
            value: '',
            customValue: _LicenseNumberChip(number: data.licenseNumber),
          ),
          SizedBox(height: 6.h),
          const Divider(),

          // ── Type ──
          _DetailRow(label: 'نوع الرخصة', value: data.licenseType),
          SizedBox(height: 6.h),
          const Divider(),
          // ── Governorate ──
          _DetailRow(label: 'المحافظة', value: data.governorate),
          SizedBox(height: 6.h),
          const Divider(),
          // ── Licensing unit ──
          _DetailRow(label: 'وحدة الترخيص', value: data.licensingUnit),
          SizedBox(height: 6.h),
          const Divider(),
          // ── Status ──
          _DetailRow(
            label: 'حالة الرخصة',
            value: '',
            customValue: _StatusChip(status: data.status),
          ),
          SizedBox(height: 6.h),
          const Divider(),
          // ── Issue date ──
          _DetailRow(label: 'تاريخ الاصدار', value: data.issueDate),
          SizedBox(height: 6.h),
          const Divider(),
          // ── Expiry date ──
          _DetailRow(label: 'تاريخ الانتهاء', value: data.expiryDate),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ──────────────────────────────────────────────────────

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

class _StatusChip extends StatelessWidget {
  final LicenseStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    String statusText = '';
    switch (status) {
      case LicenseStatus.valid:
        statusText = 'سارية';
        break;
      case LicenseStatus.withdrawn:
        statusText = 'مسحوبة';
        break;
      case LicenseStatus.expired:
        statusText = 'منتهية';
        break;
    }

    final isActive = status == LicenseStatus.valid;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF27AE60).withValues(alpha: 0.1)
            : const Color(0xFFD32F2F).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isActive ? const Color(0xFF27AE60) : const Color(0xFFD32F2F),
        ),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isActive ? const Color(0xFF27AE60) : const Color(0xFFD32F2F),
        ),
      ),
    );
  }
}

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
          style: TextStyle(
            fontFamily: 'Cairo',
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
