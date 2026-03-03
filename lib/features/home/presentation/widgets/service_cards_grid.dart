// path: lib/features/home/presentation/widgets/service_cards_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/driving_license/presentation/screens/driving_license_screen.dart';
import 'package:traffic/features/home/presentation/widgets/service_card.dart';
import 'package:traffic/features/vehicle_license/presentation/screens/vehicle_license_screen.dart';

class ServiceCardsGrid extends StatelessWidget {
  const ServiceCardsGrid({super.key});

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
