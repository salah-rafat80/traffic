import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom action buttons for the violation review screen.
/// Contains a primary "التالي" button and a secondary "تعديل الاختيارات" button.
class BottomActionButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onEdit;

  const BottomActionButtons({
    super.key,
    required this.onNext,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // ── Primary: التالي ──
            Expanded(
              child: InkWell(
                onTap: onNext,
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF27AE60),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: Text(
                      'التالي',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // ── Secondary: تعديل الاختيارات ──
            Expanded(
              child: InkWell(
                onTap: onEdit,
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF27AE60)),
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: Text(
                      'تعديل الاختيارات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF27AE60),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
