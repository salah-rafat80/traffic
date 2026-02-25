// path: lib/features/home/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/driving_license/presentation/screens/driving_license_screen.dart';
import 'package:traffic/features/home/presentation/widgets/home_header.dart';
import 'package:traffic/features/home/presentation/widgets/popular_service_item.dart';
import 'package:traffic/features/home/presentation/widgets/service_card.dart';
import 'package:traffic/features/smart_assistant/presentation/screens/smart_assistant_screen.dart';
import 'package:traffic/features/vehicle_license/presentation/screens/vehicle_license_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeHeader(),
            SizedBox(height: 32.h),
            const _PopularServicesSection(),
            SizedBox(height: 25.h),
            const _ServicesSection(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

// ─── Popular Services Section ────────────────────────────────────────────────

class _PopularServicesSection extends StatelessWidget {
  const _PopularServicesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _SectionTitle(title: 'الخدمات الاكثر شيوعاً'),
          SizedBox(height: 16.h),
          const _PopularServiceGrid(),
        ],
      ),
    );
  }
}

class _PopularServiceGrid extends StatelessWidget {
  const _PopularServiceGrid();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      clipBehavior: Clip.none,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'استعلام عن\nمخالفات',
              icon: "assets/file.svg",
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'تجديد رخصة\nقيادة',
              icon: "assets/license.svg",
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'تجديد رخصة\nمركبة',
              icon: "assets/car.svg",
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'سداد مخالفة\n رخصة القيادة',
              icon: "assets/payment.svg",
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Services Section ────────────────────────────────────────────────────────

class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _SectionTitle(title: 'الخدمات'),
          SizedBox(height: 9.h),
          const _ServiceCardsGrid(),
          SizedBox(height: 16.h),
          const _AssistantCardWidget(),
        ],
      ),
    );
  }
}

class _ServiceCardsGrid extends StatelessWidget {
  const _ServiceCardsGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: SizedBox(
            width: 165.w,
            height: 100.h,
            child: ServiceCard(
              title: 'رخصة القيادة',
              icon: "assets/driver-license-reader.svg",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DrivingLicenseScreen()),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 100.h,
            width: 165.w,
            child: ServiceCard(
              title: 'رخصة المركبة',
              icon: "assets/car.svg",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VehicleLicenseScreen()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssistantCardWidget extends StatelessWidget {
  const _AssistantCardWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ServiceCard(
        title: 'المساعد الذكي',
        icon: "assets/si_ai.svg",
        isAssistant: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SmartAssistantScreen()),
        ),
      ),
    );
  }
}

// ─── Shared ──────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }
}
