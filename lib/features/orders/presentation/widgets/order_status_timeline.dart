import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_model.dart';
import 'timeline_step_item.dart';

class OrderStatusTimeline extends StatelessWidget {
  final OrderModel order;

  const OrderStatusTimeline({super.key, required this.order});

  List<_StepData> _buildSteps() {
    final String requestDate = order.date.isNotEmpty
        ? order.date
        : 'تم التقديم بنجاح';
    final String step = order.stepCode ?? '';
    final String label = order.statusLabel;

    // Check failed states
    final bool isMedicalFailed =
        step == 'MEDICAL_EXAM_FAILED' ||
        label.contains('عدم اجتياز') ||
        label.contains('راسب') ||
        label.contains('لم يجتز') ||
        label.contains('failed') ||
        label.contains('Failed');

    // Check steps and status
    final bool isMedicalActive =
        !isMedicalFailed &&
        (step == 'MEDICAL_EXAM' ||
            step == 'MEDICAL_EXAM_BOOKING_WAITING' ||
            step == 'MEDICAL_EXAM_RESULT_WAITING' ||
            label.contains('الكشف الطبي') ||
            label.contains('طبي'));
    final bool isSchoolOrTestActive =
        !isMedicalFailed &&
        (step == 'DRIVING_SCHOOL' ||
            step == 'DRIVING_TEST' ||
            step == 'DRIVING_SCHOOL_BOOKING_WAITING' ||
            step == 'DRIVING_TEST_BOOKING_WAITING' ||
            step == 'PRACTICAL_TEST_BOOKING_WAITING' ||
            label.contains('مدرسة') ||
            label.contains('اختبار'));
    final bool isPaymentActive =
        !isMedicalFailed &&
        (step == 'PAYMENT' ||
            order.status == OrderStatus.needsData ||
            label.contains('دفع') ||
            label.contains('رسوم') ||
            label.contains('استكمال'));
    final bool isCompleted =
        !isMedicalFailed && order.status == OrderStatus.completed;

    // Determine completion of previous stages
    final bool isSubmittedDone = true;
    final bool isMedicalDone =
        !isMedicalFailed &&
        (isCompleted ||
            (!isMedicalActive &&
                step != 'MEDICAL_EXAM' &&
                (isSchoolOrTestActive || isPaymentActive)));
    final bool isSchoolTestDone =
        !isMedicalFailed &&
        (isCompleted ||
            (!isMedicalActive && !isSchoolOrTestActive && isPaymentActive));
    final bool isPaymentDone = !isMedicalFailed && isCompleted;

    return [
      _StepData(
        title: 'تم تقديم الطلب',
        dateSubtitle: requestDate,
        descSubtitle:
            'تم استلام طلب استخراج الرخصة بنجاح والتحقق من المستندات الأولية.',
        isCompleted: isSubmittedDone,
        isCurrent:
            !isMedicalActive &&
            !isSchoolOrTestActive &&
            !isPaymentActive &&
            !isCompleted &&
            !isMedicalFailed,
      ),
      _StepData(
        title: 'الفحص والكشف الطبي',
        dateSubtitle: (isMedicalActive || isMedicalFailed) ? requestDate : '',
        descSubtitle: isMedicalFailed
            ? (label.isNotEmpty
                  ? label
                  : 'لا يمكنك استكمال الطلب لعدم اجتياز الكشف الطبي.')
            : (isMedicalActive
                  ? 'بانتظار إجراء الكشف الطبي المعتمد لإرفاقه بالطلب.'
                  : (isMedicalDone
                        ? 'تم اجتياز الفحص والكشف الطبي بنجاح.'
                        : 'مرحلة الفحص الطبي المعتمد.')),
        isCompleted: isMedicalDone,
        isCurrent: isMedicalActive,
        isFailed: isMedicalFailed,
      ),
      _StepData(
        title: 'التدريب والاختبارات',
        dateSubtitle: isSchoolOrTestActive ? requestDate : '',
        descSubtitle: isSchoolOrTestActive
            ? 'جاري جدولة وحضور محاضرات مدرسة القيادة والاختبارين النظري والعملي.'
            : (isSchoolTestDone
                  ? 'تم اجتياز التدريب والاختبارات بنجاح.'
                  : 'مرحلة التدريب والاختبارات الميدانية.'),
        isCompleted: isSchoolTestDone,
        isCurrent: isSchoolOrTestActive,
      ),
      _StepData(
        title: 'دفع الرسوم وإصدار الرخصة',
        dateSubtitle: isPaymentActive ? requestDate : '',
        descSubtitle: isPaymentActive
            ? 'يرجى سداد الرسوم المقررة لاستكمال طباعة الرخصة.'
            : (isPaymentDone
                  ? 'تم سداد الرسوم وتأكيد الإصدار.'
                  : 'مرحلة سداد الرسوم والطباعة.'),
        isCompleted: isPaymentDone,
        isCurrent: isPaymentActive,
      ),
      _StepData(
        title: 'اكتمال الطلب والتسليم',
        dateSubtitle: isCompleted ? requestDate : '',
        descSubtitle: isCompleted
            ? 'تم طباعة رخصة القيادة بنجاح وتسليمها للمواطن.'
            : 'مرحلة التسليم النهائي للرخصة.',
        isCompleted: isCompleted,
        isCurrent: isCompleted,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final steps = _buildSteps();
    final String step = order.stepCode ?? '';
    final String label = order.statusLabel;
    final bool isMedicalFailed =
        step == 'MEDICAL_EXAM_FAILED' ||
        label.contains('عدم اجتياز') ||
        label.contains('راسب') ||
        label.contains('لم يجتز') ||
        label.contains('failed') ||
        label.contains('Failed');
    final bool isCompleted = order.status == OrderStatus.completed;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8F9F9),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isMedicalFailed
                ? const Color(0xFFE02424)
                : isCompleted
                ? const Color(0xFF27AE60)
                : const Color(0xFFE0E0E0),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'سجل الحالة',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];
              return TimelineStepItem(
                title: step.title,
                dateSubtitle: step.dateSubtitle,
                descSubtitle: step.descSubtitle,
                isCompleted: step.isCompleted,
                isCurrent: step.isCurrent,
                isFailed: step.isFailed,
                isLastStep: index == steps.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StepData {
  String title;
  String dateSubtitle;
  String descSubtitle;
  bool isCompleted;
  bool isCurrent;
  bool isFailed;

  _StepData({
    required this.title,
    required this.dateSubtitle,
    required this.descSubtitle,
    required this.isCompleted,
    this.isCurrent = false,
    this.isFailed = false,
  });
}
