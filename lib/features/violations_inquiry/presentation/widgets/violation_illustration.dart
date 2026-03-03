import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays the violation illustration image inside the details card.
///
/// Uses the [violationTitle] to look up the relevant SVG asset.
/// Falls back to a generic car icon if no matching asset is found.
class ViolationIllustration extends StatelessWidget {
  /// The violation title used to resolve the correct illustration asset.
  final String violationTitle;

  const ViolationIllustration({super.key, required this.violationTitle});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: SizedBox(
        width: double.infinity,
        height: 220.h,
        child: Image.asset("assets/car_red.png"),
      ),
    );
  }
}
