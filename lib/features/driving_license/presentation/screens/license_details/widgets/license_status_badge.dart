import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/driving_license/domain/enums/license_status.dart';

/// A coloured pill badge that reflects the driving licence status.
///
/// | Status     | Colour     | Arabic label |
/// |------------|------------|--------------|
/// | valid      | Green      | سارية        |
/// | expired    | Red        | منتهية       |
/// | withdrawn  | Orange     | مسحوبة       |
class LicenseStatusBadge extends StatelessWidget {
  final LicenseStatus status;

  const LicenseStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: _badgeColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        _badgeLabel,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFF8F9F9),
        ),
      ),
    );
  }

  Color get _badgeColor {
    switch (status) {
      case LicenseStatus.valid:
        return const Color(0xFF27AE60);
      case LicenseStatus.expired:
        return const Color(0xFFE53935);
      case LicenseStatus.withdrawn:
        return const Color(0xFFEA9555);
    }
  }

  String get _badgeLabel {
    switch (status) {
      case LicenseStatus.valid:
        return 'سارية';
      case LicenseStatus.expired:
        return 'منتهية';
      case LicenseStatus.withdrawn:
        return 'مسحوبة';
    }
  }
}
