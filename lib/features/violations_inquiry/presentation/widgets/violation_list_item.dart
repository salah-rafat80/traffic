import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffic/features/violations_inquiry/data/models/violation_model.dart';

/// Maps violation titles to SVG asset paths.
const _violationSvgMap = <String, String>{
  'تجاوز السرعة المقررة': 'assets/تجاوز السرعة المقررة.svg',
  'عدم الربط حزام الامان': 'assets/عدم  ارتداء حزام الامان.svg',
  'عدم  ارتداء حزام الامان': 'assets/عدم  ارتداء حزام الامان.svg',
  'انتظار خاطئ': 'assets/انتظار خاطئ.svg',
};

/// A card widget for each violation in the list.
/// Shows title, warning icon, amount, violation number, location, date/time.
class ViolationListItem extends StatelessWidget {
  final ViolationModel violation;
  final VoidCallback onTap;
  final bool isSelected;
  final ValueChanged<bool>? onSelect;

  const ViolationListItem({
    super.key,
    required this.violation,
    required this.onTap,
    this.isSelected = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── Top Row: Checkbox + Title & Amount + Icon ──
          Row(
            textDirection: TextDirection.rtl,
            children: [
              // Icon on the Right (First in RTL)
              if (_violationSvgMap.containsKey(violation.title))
                Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4ECDE),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      _violationSvgMap[violation.title]!,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                )
              else
                Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: SvgPicture.asset(
                    'assets/license.svg', // Fallback icon
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF2E7D32),
                      BlendMode.srcIn,
                    ),
                  ),
                ),

              SizedBox(width: 12.w),

              // Title & Amount Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      violation.title,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${violation.amount.toInt()} جنية مصري',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 10.w),

              // Checkbox (18x18, green #27AE60)
              if (!violation.isPaid)
                GestureDetector(
                  onTap: () => onSelect?.call(!isSelected),
                  child: Container(
                    width: 18.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF27AE60)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: const Color(0xFF27AE60),
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? Icon(Icons.check, size: 14.w, color: Colors.white)
                        : null,
                  ),
                )
              else
                // Spacer or Paid Badge if needed, but for now just empty space to keep layout if necessary
                // though Expanded will take it.
                SizedBox(width: 18.w), 

            ],
          ),

          SizedBox(height: 14.h),

          // ── Divider ──
          const Divider(color: Color(0xFFEEEEEE), height: 1),
          SizedBox(height: 14.h),

          // ── Violation number row ──
          Row(
            textDirection: TextDirection.ltr,

            children: [
              // Green badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  violation.violationNumber,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              // Label
              Text(
                'رقم المخالفة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF555555),
                ),
              ),
              SizedBox(width: 6.w),
              // Copy icon
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: violation.violationNumber),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم نسخ رقم المخالفة'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child:               SvgPicture.asset("assets/mingcute_ticket-line.svg", width: 25.w, height: 25.h),

              ),
            ],
          ),
          SizedBox(height: 10.h),

          // ── Location row ──
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                violation.location,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF555555),
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.location_on,
                size: 25.w,
                color: const Color(0xFF2E7D32),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // ── Date & time row ──
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${violation.time} , ${violation.date}',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF555555),
                ),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset("assets/stash_data-date-light.svg", width: 25.w, height: 25.h),
            ],
          ),
          SizedBox(height: 10.h),

          // ── View details link ──
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                'عرض التفاصيل',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2E7D32),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF2E7D32),
                  decorationThickness: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
