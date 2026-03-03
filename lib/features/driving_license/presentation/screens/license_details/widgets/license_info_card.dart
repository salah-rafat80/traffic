import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/Radio_dot.dart';
import 'package:traffic/core/widgets/info_row_item.dart';
import 'package:traffic/features/violations_inquiry/data/models/license_model.dart';
import 'license_status_badge.dart';

/// A card widget that displays the full licence details in a clean, bordered
/// container. Each info row is rendered via [InfoRowItem] and the status
/// row uses a [LicenseStatusBadge] widget.
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
      decoration: ShapeDecoration(
        color: const Color(0xFFF8F9F9),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFFDADADA)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Radio button ──
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RadioDot(isSelected: isSelected),
            ),
          ),
          SizedBox(height: 12.h),

          // ── Licence Number ─────────────────────────────────────────────────
          InfoRowItem(
            label: 'رقم الرخصة',
            valueWidget: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFF27AE60),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                data.licenseNumber,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF8F9F9),
                ),
              ),
            ),
          ),

          // ── Licence Type ───────────────────────────────────────────────────
          InfoRowItem(label: 'نوع الرخصة', value: data.licenseType),

          // ── Governorate ────────────────────────────────────────────────────
          InfoRowItem(label: 'المحافظة', value: data.governorate),

          // ── Licensing Unit ─────────────────────────────────────────────────
          InfoRowItem(label: 'وحدة الترخيص', value: data.licensingUnit),

          // ── Status ─────────────────────────────────────────────────────────
          InfoRowItem(
            label: 'حالة الرخصة',
            valueWidget: LicenseStatusBadge(status: data.status),
          ),

          // ── Issue Date ─────────────────────────────────────────────────────
          InfoRowItem(label: 'تاريخ الاصدار', value: data.issueDate),

          // ── Expiry Date (last row — no divider) ────────────────────────────
          InfoRowItem(
            label: 'تاريخ الانتهاء',
            value: data.expiryDate,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
