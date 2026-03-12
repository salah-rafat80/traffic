import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimelineStepItem extends StatelessWidget {
  final String title;
  final String dateSubtitle;
  final String descSubtitle;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLastStep;

  const TimelineStepItem({
    super.key,
    required this.title,
    required this.dateSubtitle,
    required this.descSubtitle,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  dateSubtitle,
                  style: TextStyle(
                    color: const Color(0xFF707070),
                    fontSize: 12.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (descSubtitle.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    descSubtitle,
                    style: TextStyle(
                      color: const Color(0xFF707070),
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (!isLastStep) SizedBox(height: 16.h),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: ShapeDecoration(
                  color: isCompleted
                      ? const Color(0xFFD4ECDE)
                      : isCurrent
                          ? const Color(0xFFA5D4FF)
                          : const Color(0xFFE0E0E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(
                          Icons.check_circle,
                          color: const Color(0xFF27AE60),
                          size: 16.r,
                        )
                      : isCurrent
                          ? Container(
                              width: 14.w,
                              height: 14.w,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF3B82F6),
                                shape: OvalBorder(),
                              ),
                            )
                          : const SizedBox.shrink(),
                ),
              ),
              if (!isLastStep)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: isCompleted
                        ? const Color(0xFFD4ECDE) // completed line color
                        : const Color(0xFFE0E0E0), // inactive line color
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
