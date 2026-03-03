import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card that displays a centered camera icon with a light-green background.
/// Used on the vehicle inspection landing screen.
class InspectionCameraIconCard extends StatelessWidget {
  const InspectionCameraIconCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
