import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsuranceCompanyCard extends StatelessWidget {
  final String companyName;
  final String details;
  final String logoAssetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const InsuranceCompanyCard({
    super.key,
    required this.companyName,
    required this.details,
    required this.logoAssetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF27AE60)
                : const Color(0xFFDADADA),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo area
            SizedBox(
              height: 100.h,
              width: double.infinity,
              child: Image.asset(
                logoAssetPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if image not found
                  return Container(
                    color: const Color(0xFFF8F9F9),
                    alignment: Alignment.center,
                    child: Image.asset("assets/الشركة المصرية للتأمين .png"),
                  );
                },
              ),
            ),

            // Details and Radio
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          companyName,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: const Color(0xFF222222),
                            fontSize: 14.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          details,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: const Color(0xFF444444),
                            fontSize: 10.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Radio Indicator
                  Container(
                    width: 20.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFD4ECDE)
                          : const Color(0xFFF8F9F9),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? null
                          : Border.all(
                              color: const Color(0xFFDADADA),
                              width: 1.w,
                            ),
                    ),
                    child: isSelected
                        ? Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF27AE60),
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
