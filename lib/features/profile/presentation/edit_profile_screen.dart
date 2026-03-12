import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/primary_button.dart';
import '../../lost_license/presentation/widgets/custom_text_form_field.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_info_row.dart';
import 'widgets/security_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Simulate initial data
    _nameController = TextEditingController(text: 'Amira Essam');
    _emailController = TextEditingController(text: '42022248@hti.edu.eg');
    _phoneController = TextEditingController(text: '010123456789099');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildSectionTitle('البيانات الشخصية'),
                    SizedBox(height: 8.h),
                    _buildPersonalInfoCard(),
                    SizedBox(height: 24.h),
                    _buildSectionTitle('معلومات التواصل'),
                    SizedBox(height: 8.h),
                    _buildContactInfoCard(),
                    SizedBox(height: 24.h),
                    _buildSectionTitle('الأمان'),
                    SizedBox(height: 8.h),
                    const SecurityCard(),
                    SizedBox(height: 32.h),
                    PrimaryButton(
                      label: 'حفظ التغيرات',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Call UpdateProfile Cubit method here
                          // Simulate success and pop
                          Navigator.pop(context);
                        }
                      },
                      backgroundColor: const Color(0xFF27AE60),
                    ),
                    SizedBox(height: 16.h),
                    _buildCancelButton(),
                    SizedBox(height: 20.h),
                  ],
                ),
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

  Widget _buildPersonalInfoCard() {
    return Container(
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
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'الاسم الكامل',
            hintText: 'ادخل الاسم الكامل',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'برجاء إدخال الاسم الكامل';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFFDADADA), thickness: 1.r),
          ProfileInfoRow(
            label: 'الرقم القومي',
            value: '010123456789099',
            icon: Icons.badge_outlined,
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                'غير قابل للتعديل',
                style: TextStyle(
                  color: const Color(0xFF707070),
                  fontSize: 9.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            labelText: 'البريد الالكتروني',
            hintText: 'ادخل البريد الالكتروني',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'برجاء إدخال البريد الالكتروني';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                return 'برجاء إدخال بريد الكتروني صحيح';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              'سيتم إرسال رمز تحقق عند تغيير البريد الالكتروني',
              style: TextStyle(
                color: const Color(0xFFE53935),
                fontSize: 10.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Divider(color: const Color(0xFFDADADA), thickness: 1.r),
          SizedBox(height: 16.h),
          CustomTextFormField(
            labelText: 'رقم الهاتف',
            hintText: 'ادخل رقم الهاتف',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'برجاء إدخال رقم الهاتف';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9F9),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color(0xFF27AE60), width: 1.r),
        ),
        child: Center(
          child: Text(
            'الغاء',
            style: TextStyle(
              color: const Color(0xFF27AE60),
              fontSize: 18.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
