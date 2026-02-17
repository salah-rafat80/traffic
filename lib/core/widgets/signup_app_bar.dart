import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/custom_appbar.dart';

class SignupAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String step;
  final String? nextStepText; // "التالي : البيانات الشخصية"
  final VoidCallback? onBackPressed;

  const SignupAppBar({
    super.key,
    required this.step,
    this.nextStepText,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(150.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppbar(onBackPressed: onBackPressed, title: "إنشاء حساب"),
              SizedBox(height: 12.h),
              Row(children: _buildProgressBars()),
              SizedBox(height: 8.h),
              // Row 3: Step number + Next step text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Next step text - LEFT side
                  if (nextStepText != null)
                    Flexible(
                      child: Text(
                        nextStepText!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF999999),
                          fontFamily: 'Tajawal',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  else
                    const SizedBox(),
                  // Step number
                  Text(
                    step,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF666666),
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProgressBars() {
    final int currentStep = _getCurrentStep();
    return List.generate(3, (index) {
      // Reverse index for RTL (3, 2, 1 instead of 1, 2, 3)
      final int rtlIndex = 2 - index;
      final bool isActive = rtlIndex < currentStep;
      return Expanded(
        child: Container(
          height: 4.h,
          margin: EdgeInsets.only(left: 3.w),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF27AE60) : const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      );
    });
  }

  int _getCurrentStep() {
    final parsed = int.tryParse(step);
    if (parsed != null && parsed >= 1 && parsed <= 3) return parsed;
    if (step.contains('1')) return 1;
    if (step.contains('2')) return 2;
    if (step.contains('3')) return 3;
    return 1;
  }
}
