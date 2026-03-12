import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/primary_button.dart';
import 'widgets/profile_header.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/contact_info_card.dart';
import 'widgets/security_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const ProfileHeader(title: 'حسابي'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSectionTitle('البيانات الشخصية'),
                  SizedBox(height: 8.h),
                  const PersonalInfoCard(
                    fullName: 'اميرة عصام حامد',
                    nationalId: '010123456789099',
                  ),
                  SizedBox(height: 24.h),
                  _buildSectionTitle('معلومات التواصل'),
                  SizedBox(height: 8.h),
                  const ContactInfoCard(
                    email: '42022248@hti.edu.eg',
                    phoneNumber: '010123456789099',
                  ),
                  SizedBox(height: 24.h),
                  _buildSectionTitle('الأمان'),
                  SizedBox(height: 8.h),
                  const SecurityCard(),
                  SizedBox(height: 32.h),
                  PrimaryButton(
                    label: 'تعديل البيانات',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF27AE60),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF222222),
        fontSize: 17.sp,
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
