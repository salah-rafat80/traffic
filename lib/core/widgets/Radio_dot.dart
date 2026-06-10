import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RadioDot extends StatelessWidget {
  final bool isSelected;
  const RadioDot({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isSelected ? 'assets/dot_active.svg' : 'assets/dot_no_active.svg',
      width: 22.w,
      height: 22.w,
    );
  }
}
