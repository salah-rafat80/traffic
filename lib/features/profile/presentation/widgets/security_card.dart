import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../change_password_screen.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChangePasswordScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9F9),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color(0xFFDADADA), width: 1.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(
              Icons.lock_outline,
              size: 20.r,
              color: const Color(0xFF27AE60),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'تغيير كلمة المرور',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: const Color(0xFF222222),
                  fontSize: 12.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
