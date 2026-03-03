import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/vehicle_inspection/presentation/screens/vehicle_inspection_camera_screen.dart';
import 'package:traffic/features/vehicle_inspection/presentation/widgets/inspection_bullet_point.dart';
import 'package:traffic/features/vehicle_inspection/presentation/widgets/inspection_camera_icon_card.dart';
import 'package:traffic/features/vehicle_inspection/presentation/widgets/inspection_start_button.dart';

/// Screen 1 — Landing / Start screen for AI vehicle inspection.
///
/// Shows a camera-icon card, three feature bullet points, and a
/// "بدء الفحص" (Start Inspection) button.
class VehicleInspectionScreen extends StatefulWidget {
  const VehicleInspectionScreen({super.key});

  @override
  State<VehicleInspectionScreen> createState() =>
      _VehicleInspectionScreenState();
}

class _VehicleInspectionScreenState extends State<VehicleInspectionScreen> {
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
            title: 'فحص المركبة بالذكاء الاصطناعي',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // ── Camera icon card ──
                  const InspectionCameraIconCard(),

                  SizedBox(height: 32.h),

                  // ── Feature bullet points ──
                  const InspectionBulletPoint(
                    text: 'صوّر سيارتك واحصل على تقرير فوري عن حالتها.',
                  ),
                  SizedBox(height: 16.h),
                  const InspectionBulletPoint(
                    text: 'اكتشف أي مشاكل محتملة قبل الذهاب للمرور.',
                  ),
                  SizedBox(height: 16.h),
                  const InspectionBulletPoint(
                    text: 'فحص سريع وبسيط لتتأكد أن سيارتك جاهزة وآمنة.',
                  ),

                  const Spacer(),

                  // ── Start inspection button ──
                  InspectionStartButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VehicleInspectionCameraScreen(),
                        ),
                      );
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
