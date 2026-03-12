import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/profile/presentation/widgets/profile_header.dart';

import '../widgets/logout_button.dart';
import '../widgets/settings_menu_item.dart';
import 'faq_screen.dart';
import 'support_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: Column(
        children: [
          const ProfileHeader(title: 'الاعدادات'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'المساعدة والدعم',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9F9),
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: const Color(0xFFDADADA),
                        width: 1.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3F000000),
                          blurRadius: 4.r,
                          offset: Offset(0, 1.h),
                        ),
                      ],
                    ),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        SettingsMenuItem(
                          title: 'الاسئلة الشائعة',
                          icon: Icons.help_outline,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FaqScreen(),
                              ),
                            );
                          },
                        ),
                        SettingsMenuItem(
                          title: 'التواصل مع الدعم',
                          icon: Icons.call_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SupportScreen(),
                              ),
                            );
                          },
                        ),
                        SettingsMenuItem(
                          title: 'المساعد الذكي',
                          icon: Icons.smart_toy_outlined,
                          showDivider: false,
                          onTap: () {
                            // TODO: Navigate to Smart Assistant
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Text(
                    'عن التطبيق',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9F9),
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: const Color(0xFFDADADA),
                        width: 1.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3F000000),
                          blurRadius: 4.r,
                          offset: Offset(0, 1.h),
                        ),
                      ],
                    ),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        SettingsMenuItem(
                          title: 'عن التطبيق',
                          icon: Icons.info_outline,
                          onTap: () {
                            // TODO: Navigate to About App
                          },
                        ),
                        SettingsMenuItem(
                          title: 'شروط الاستخدام',
                          icon: Icons.article_outlined,
                          onTap: () {
                            // TODO: Navigate to Terms of Use
                          },
                        ),
                        SettingsMenuItem(
                          title: 'سياسة الخصوصية',
                          icon: Icons.lock_outline,
                          onTap: () {
                            // TODO: Navigate to Privacy Policy
                          },
                        ),
                        SettingsMenuItem(
                          title: 'اصدار التطبيق',
                          icon: Icons.qr_code_scanner_outlined,
                          trailingText: 'v1.2.4',
                          hideArrow: true,
                          showDivider: false,
                          onTap: () {
                            // TODO: Action for App Version
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  LogoutButton(
                    onTap: () {
                      // TODO: Implement logout logic
                    },
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
