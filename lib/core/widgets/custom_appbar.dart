import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.onBackPressed,
    required this.title,
  });

  final VoidCallback? onBackPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        SizedBox(
          height: 60.h,
          width: 60.w,
          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
        ),

        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: onBackPressed ?? () => Navigator.pop(context),
                    child: SvgPicture.asset('assets/weui_arrow-filled.svg'),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Tajawal',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
