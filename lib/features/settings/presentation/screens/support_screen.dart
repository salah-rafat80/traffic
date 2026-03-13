import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';

import '../widgets/support_option_card.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: "التواصل مع الدعم",
            onMenuPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
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
        ],
      ),
    );
  }
}
