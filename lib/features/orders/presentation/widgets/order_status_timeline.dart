import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_model.dart';
import 'timeline_step_item.dart';

class OrderStatusTimeline extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusTimeline({
    super.key,
    required this.status,
  });

  List<_StepData> _buildSteps() {
    // We build steps based on status.
    final List<_StepData> steps = [
      _StepData(
        title: 'تم تقديم الطلب',
        dateSubtitle: '25 اكتوبر 2025',
        descSubtitle: 'تم استلام طلب استخراج الرخصة',
        isCompleted: true, // we assume it's always at least step 1
      ),
      _StepData(
        title: 'تم قبول الطلب',
        dateSubtitle: '25 اكتوبر 2025',
        descSubtitle: 'تمت الموافقة علي الطلب',
        isCompleted: true,
        isCurrent: status == OrderStatus.pending,
      ),
    ];

    switch (status) {
      case OrderStatus.pending:
        steps.add(_StepData(
          title: 'قيد التنفيذ',
          dateSubtitle: '25 اكتوبر 2025',
          descSubtitle: 'جاري معالجة الطلب',
          isCompleted: false,
          isCurrent: true, // Wait, if pending, processing is next? Let's say step 2 is current in pending.
        ));
        break;
      case OrderStatus.awaitingService:
        steps.last.isCompleted = true; // Step 2 is completed
        steps.last.isCurrent = false;

        steps.add(_StepData(
          title: 'بانتظار الموعد',
          dateSubtitle: '25 اكتوبر 2025',
          descSubtitle: 'يرجى حجز موعد للاختبار',
          isCompleted: false,
          isCurrent: true,
        ));
        break;
      case OrderStatus.completed:
      case OrderStatus.passed:
        steps.last.isCompleted = true;
        steps.last.isCurrent = false;

        steps.add(_StepData(
          title: 'قيد التنفيذ',
          dateSubtitle: '25 اكتوبر 2025',
          descSubtitle: 'يتم طباعة الرخصة',
          isCompleted: true,
        ));

        steps.add(_StepData(
          title: 'مكتمل',
          dateSubtitle: '25 اكتوبر 2025',
          descSubtitle: 'تم توصيل الرخصة',
          isCompleted: true,
          isCurrent: true,
        ));
        break;
      case OrderStatus.needsData:
        steps.last.isCompleted = false;
        steps.last.isCurrent = false;

        steps.add(_StepData(
          title: 'بحاجة لبيانات',
          dateSubtitle: '25 اكتوبر 2025',
          descSubtitle: 'يرجى استكمال البيانات',
          isCompleted: false,
          isCurrent: true,
        ));
        break;
      case OrderStatus.failed:
        steps.last.isCompleted = true;
        steps.last.isCurrent = false;

        steps.add(_StepData(
          title: 'راسب',
          dateSubtitle: '25 اكتوبر 2025',
          descSubtitle: 'لم يتم اجتياز الاختبار',
          isCompleted: false,
          isCurrent: true,
        ));
        break;
    }

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    final steps = _buildSteps();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8F9F9),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFF27AE60),
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          )
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

  _StepData({
    required this.title,
    required this.dateSubtitle,
    required this.descSubtitle,
    required this.isCompleted,
    this.isCurrent = false,
  });
}
