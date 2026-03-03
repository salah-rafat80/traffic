// path: lib/features/home/presentation/widgets/popular_service_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/home/presentation/widgets/popular_service_item.dart';

class PopularServiceGrid extends StatelessWidget {
  const PopularServiceGrid({super.key});

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
