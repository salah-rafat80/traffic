// path: lib/features/home/presentation/widgets/popular_services_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/home/presentation/widgets/popular_service_grid.dart';
import 'package:traffic/features/home/presentation/widgets/section_title.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SectionTitle(title: 'الخدمات الاكثر شيوعاً'),
          SizedBox(height: 16.h),
          const PopularServiceGrid(),
        ],
      ),
    );
  }
}
