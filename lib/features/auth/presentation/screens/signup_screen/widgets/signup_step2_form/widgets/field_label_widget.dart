import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldLabelWidget extends StatelessWidget {
  final String label;

  const FieldLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: 'Tajawal',
      ),
    );
  }
}
