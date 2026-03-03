import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioDot extends StatelessWidget {
  final bool isSelected;
  const RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? const Color(0xFF27AE60) : const Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF27AE60),
                ),
              ),
            )
          : null,
    );
  }
}
