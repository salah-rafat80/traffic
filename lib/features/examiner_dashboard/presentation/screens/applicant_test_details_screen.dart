import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/service_screen_appbar.dart';
import '../../data/models/dashboard_config.dart';
import '../../data/models/staff_appointment_model.dart';
import '../cubits/examiner_cubit.dart';
import '../cubits/examiner_state.dart';
import '../widgets/test_result_buttons.dart';
import 'package:traffic/injection_container.dart';

class ApplicantTestDetailsScreen extends StatelessWidget {
  final DashboardConfig config;
  final StaffAppointmentModel appointment;

  const ApplicantTestDetailsScreen({
    super.key,
    required this.config,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExaminerCubit>(),
      child: BlocConsumer<ExaminerCubit, ExaminerState>(
        listener: (context, state) {
          if (state is ExaminerSubmitSuccess) {
            _showSuccessDialog(context, state.passed);
          } else if (state is ExaminerFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  ServiceScreenAppBar(title: config.detailsTitle),
                  SizedBox(height: 16.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      config.applicantDetailsLabel,
                      style: TextStyle(
                        color: const Color(0xFF222222),
                        fontSize: 17.sp,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.all(16.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9F9),
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: const Color(0xFFAEAEAE),
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x3F000000),
                                  blurRadius: 4.r,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildStrictInfoRow(
                                  config.requestNumberLabel,
                                  appointment.requestNumberRelated ?? '-',
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  'الرقم القومي',
                                  appointment.citizenNationalId ?? '-',
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  config.testTypeLabel,
                                  '',
                                  valueWidget: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: config.typeTagColor.withValues(
                                        alpha: 0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      appointment.typeName ??
                                          config.typeTagText,
                                      style: TextStyle(
                                        color: config.typeTagColor,
                                        fontSize: 15.sp,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  'تاريخ الحجز',
                                  appointment.displayDate,
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  'وقت الحجز',
                                  appointment.displayTime,
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  'الحالة الحالية',
                                  appointment.status ?? '-',
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  'المحافظة',
                                  appointment.governorateName ?? '-',
                                ),
                                SizedBox(height: 16.h),
                                _buildStrictInfoRow(
                                  'وحدة المرور',
                                  appointment.trafficUnitName ?? '-',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          if (state is ExaminerSubmitLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (appointment.status == 'محجوز')
                            TestResultButtons(
                              passLabel: config.passButtonText,
                              failLabel: config.failButtonText,
                              onPass: () =>
                                  _showConfirmationDialog(context, true),
                              onFail: () =>
                                  _showConfirmationDialog(context, false),
                            )
                          else
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                'تم تسجيل النتيجة مسبقاً: ${appointment.status}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStrictInfoRow(
    String label,
    String value, {
    Widget? valueWidget,
  }) {
    return Row(
      children: [
        valueWidget ??
            Text(
              value,
              textAlign: TextAlign.start,
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
          textAlign: TextAlign.center,
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

  void _showConfirmationDialog(BuildContext context, bool isPass) {
    final examinerCubit = context.read<ExaminerCubit>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: examinerCubit,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    config.resultConfirmationTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (isPass
                                  ? const Color(0xFF27AE60)
                                  : const Color(0xFFE53935))
                              .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      isPass ? config.passButtonText : config.failButtonText,
                      style: TextStyle(
                        color: isPass
                            ? const Color(0xFF27AE60)
                            : const Color(0xFFE53935),
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close confirm dialog
                      examinerCubit.submitResult(
                        requestNumber: appointment.requestNumberRelated ?? '',
                        passed: isPass,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27AE60),
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'تأكيد',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                      side: const BorderSide(color: Color(0xFF27AE60)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'الغاء',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF27AE60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, bool isPass) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تم تسجيل النتيجة بنجاح',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (isPass
                                ? const Color(0xFF27AE60)
                                : const Color(0xFFE53935))
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    isPass ? config.passButtonText : config.failButtonText,
                    style: TextStyle(
                      color: isPass
                          ? const Color(0xFF27AE60)
                          : const Color(0xFFE53935),
                      fontFamily: 'Cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close success dialog
                    Navigator.pop(context); // Back to list
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'العودة للقائمة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
