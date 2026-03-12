import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/support_option_card.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9F9),
        elevation: 1,
        shadowColor: const Color(0x33000000),
        centerTitle: true,
        title: Text(
          'التواصل مع الدعم',
          style: TextStyle(
            color: const Color(0xFF222222),
            fontSize: 18.sp,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'نحن هنا لمساعدتك ,اختر طريقة التواصل المناسبة لك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 13.sp,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              SupportOptionCard(
                title: 'الاتصال الهاتفي',
                subtitle: '123456789098',
                buttonText: 'اتصل الان',
                onActionPressed: () {
                  // TODO: Implement URL Launcher for tel://
                },
              ),
              SizedBox(height: 16.h),
              SupportOptionCard(
                title: 'البريد الالكتروني',
                subtitle: 'moroork123@gmail.com',
                buttonText: 'ارسال رسالة',
                onActionPressed: () {
                  // TODO: Implement URL Launcher for mailto://
                },
              ),
              SizedBox(height: 16.h),
              SupportOptionCard(
                title: 'الدردشة المباشرة',
                buttonText: 'بدء المحادثة',
                onActionPressed: () {
                  // TODO: Implement Chat initialization
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
