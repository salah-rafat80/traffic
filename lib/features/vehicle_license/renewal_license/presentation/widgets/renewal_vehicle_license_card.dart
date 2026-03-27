import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/radio_dot.dart';
import '../../data/models/renewal_vehicle_license_model.dart';
import 'renewal_card_banners.dart';

// ── Public widget ─────────────────────────────────────────────────────────────

class RenewalVehicleLicenseCard extends StatelessWidget {
  final RenewalVehicleLicenseModel vehicle;
  final bool isSelected;
  final VoidCallback? onTap;

  const RenewalVehicleLicenseCard({
    super.key,
    required this.vehicle,
    this.isSelected = false,
    this.onTap,
  });

  bool get _isRestricted =>
      vehicle.status == RenewalLicenseStatus.suspended ||
      vehicle.status == RenewalLicenseStatus.withdrawn;

  bool get _canSelect => vehicle.canRenew;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: _canSelect ? onTap : null,
        child: Opacity(
          opacity: _isRestricted ? 0.6 : 1.0,
          child: Container(
            padding: EdgeInsetsDirectional.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9F9),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF27AE60)
                    : const Color(0xFFDADADA),
                width: isSelected ? 2.w : 1.w,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_canSelect) RadioDot(isSelected: isSelected),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      'رقم اللوحة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    const Spacer(),
                    RenewalBadge(
                      text: vehicle.plateNumber,
                      color: const Color(0xFF27AE60),
                    ),
                  ],
                ),
                const RenewalDivider(),
                RenewalInfoRow(label: 'نوع المركبة', value: vehicle.vehicleType),
                const RenewalDivider(),
                RenewalInfoRow(label: 'تاريخ انتهاء', value: vehicle.expiryDate),
                const RenewalDivider(),
                RenewalInfoRow(
                  label: 'حالة الرخصة',
                  valueWidget: RenewalStatusBadge(status: vehicle.status),
                ),
                if (vehicle.hasUnpaidViolations) ...[
                  SizedBox(height: 10.h),
                  RenewalWarningBanner(
                    message:
                        'توجد مخالفات غير مدفوعة علي هذه الرخصة تمنع التجديد',
                    linkText: 'عرض المخالفات',
                    onLinkTap: () {},
                  ),
                ],
                if (vehicle.needsTechnicalInspection) ...[
                  SizedBox(height: 10.h),
                  const RenewalInfoBanner(
                    message: 'يجب إجراء فحص فني للمركبة قبل التجديد',
                    color: Color(0xFFFFF3E0),
                    textColor: Color(0xFFE65100),
                  ),
                ],
                if (vehicle.needsInsuranceRenewal) ...[
                  SizedBox(height: 10.h),
                  const RenewalInfoBanner(
                    message: 'اكتمل ملف التأمين، يرجى التأكد قبل الاستمرار',
                    color: Color(0xFFFFF3E0),
                    textColor: Color(0xFFE65100),
                  ),
                ],
                if (_isRestricted) ...[
                  SizedBox(height: 8.h),
                  Text(
                    'لا يمكن اصدار بدل لهذه الرخصة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE53935),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
