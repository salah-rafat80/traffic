import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_list_item.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/smart_assistant/presentation/screens/smart_assistant_chat_screen.dart';
import 'package:traffic/features/vehicle_inspection/presentation/screens/vehicle_inspection_screen.dart';

class SmartAssistantScreen extends StatefulWidget {
  const SmartAssistantScreen({super.key});

  @override
  State<SmartAssistantScreen> createState() => _SmartAssistantScreenState();
}

class _SmartAssistantScreenState extends State<SmartAssistantScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'المساعد الذكي',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),          SizedBox(height: 5.h,),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 24.h),

                  // ── Description text ──
                  Text(
                    'خدمة ذكية تساعدك في فحص سيارتك، الإجابة على استفساراتك، ومساعدتك في إجراءات المرور باستخدام الذكاء الاصطناعي',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF333333),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // ── Action buttons ──
                  ServiceListItem(
                    title: 'محادثة المساعد الذكي',
                    icon: "assets/ai_robot.svg",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SmartAssistantChatScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'فحص المركبة بالذكاء الاصطناعي',
                    icon: "assets/search.svg",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VehicleInspectionScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
