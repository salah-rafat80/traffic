// path: lib/features/home/presentation/widgets/services_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/home/presentation/widgets/assistant_card_widget.dart';
import 'package:traffic/features/home/presentation/widgets/section_title.dart';
import 'package:traffic/features/home/presentation/widgets/service_cards_grid.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SectionTitle(title: 'الخدمات'),
          SizedBox(height: 9.h),
          const ServiceCardsGrid(),
          SizedBox(height: 16.h),
          const AssistantCardWidget(),
        ],
      ),
    );
  }
}
