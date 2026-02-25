import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/vehicle_inspection/presentation/screens/vehicle_inspection_camera_screen.dart';

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
          SizedBox(height: 5.h,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // ── Camera icon card ──
                  Container(
                    width: double.infinity,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7F0),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 40.w,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // ── Feature bullet points ──
                  _buildBulletPoint(
                    'صوّر سيارتك واحصل على تقرير فوري عن حالتها.',
                  ),
                  SizedBox(height: 16.h),
                  _buildBulletPoint('اكتشف أي مشاكل محتملة قبل الذهاب للمرور.'),
                  SizedBox(height: 16.h),
                  _buildBulletPoint(
                    'فحص سريع وبسيط لتتأكد أن سيارتك جاهزة وآمنة.',
                  ),

                  const Spacer(),

                  // ── Start inspection button ──
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const VehicleInspectionCameraScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'بدء الفحص',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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

  Widget _buildBulletPoint(String text) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF333333),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(
            Icons.check_circle,
            size: 20.w,
            color: const Color(0xFF2E7D32),
          ),
        ),
      ],
    );
  }
}
