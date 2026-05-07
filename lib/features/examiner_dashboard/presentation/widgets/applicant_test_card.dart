import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicantTestCard extends StatelessWidget {
  final String orderNo;
  final String applicantName;
  final String time;
  final String buttonText;
  final String requestNumberLabel;
  final VoidCallback onViewDetails;

  const ApplicantTestCard({
    super.key,
    required this.orderNo,
    required this.applicantName,
    required this.time,
    required this.buttonText,
    required this.requestNumberLabel,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: const Color(0xFF27AE60), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        // textDirection: TextDirection.rtl,
        children: [
          _buildInfoRow(requestNumberLabel, orderNo),
          SizedBox(height: 10.h),
          _buildInfoRow('الرقم القومي', applicantName),
          SizedBox(height: 10.h),
          _buildInfoRow('الوقت', time),
          SizedBox(height: 10.h),
          const Divider(color: Color(0xFFDADADA)),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: onViewDetails,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  buttonText,
                  style: TextStyle(
                    color: const Color(0xFF27AE60),
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF222222),
            fontSize: 15.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF707070),
            fontSize: 12.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
