// path: lib/features/home/presentation/widgets/popular_service_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/driving_license/presentation/screens/license_details/license_details_screen.dart';
import 'package:traffic/features/home/presentation/widgets/popular_service_item.dart';
import 'package:traffic/features/vehicle_license/renewal_license/presentation/screens/renewal_vehicle_selection_screen.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/select_license_screen.dart';

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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SelectLicenseScreen()),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'تجديد رخصة\nقيادة',
              icon: "assets/license.svg",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LicenseDetailsScreen(),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'تجديد رخصة\nمركبة',
              icon: "assets/car.svg",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RenewalVehicleSelectionScreen(),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 135.w,
            child: PopularServiceItem(
              title: 'سداد مخالفة\n رخصة القيادة',
              icon: "assets/payment.svg",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SelectLicenseScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
