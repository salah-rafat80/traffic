import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays the captured vehicle image in a rounded container.
class CapturedImagePreview extends StatelessWidget {
  /// The local file-system path to the captured image.
  final String imagePath;

  const CapturedImagePreview({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          width: double.infinity,
          child: Image.file(File(imagePath), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
