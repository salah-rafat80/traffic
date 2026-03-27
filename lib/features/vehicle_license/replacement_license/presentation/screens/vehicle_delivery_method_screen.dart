import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/checkout/generic_order_review_screen.dart';
import 'package:traffic/core/features/checkout/models/applicant_details.dart';
import 'package:traffic/core/features/checkout/models/fees_details.dart';
import 'package:traffic/core/features/checkout/models/order_summary.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/selection_option_card.dart';
import '../../data/models/vehicle_license_model.dart';
import 'vehicle_replacement_type_selection_screen.dart';

enum VehicleDeliveryMethod { pickup, delivery }

class VehicleDeliveryMethodScreen extends StatefulWidget {
  final VehicleLicenseModel vehicle;
  final VehicleReplacementType replacementType;

  const VehicleDeliveryMethodScreen({
    super.key,
    required this.vehicle,
    required this.replacementType,
  });

  @override
  State<VehicleDeliveryMethodScreen> createState() =>
      _VehicleDeliveryMethodScreenState();
}

class _VehicleDeliveryMethodScreenState extends State<VehicleDeliveryMethodScreen> {
  VehicleDeliveryMethod? selectedMethod;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressDetailsController = TextEditingController();

  @override
  void dispose() {
    _governorateController.dispose();
    _cityController.dispose();
    _addressDetailsController.dispose();
    super.dispose();
  }

  bool get _isButtonEnabled => selectedMethod != null;

  void _onNextPressed() {
    if (selectedMethod == VehicleDeliveryMethod.delivery) {
      if (!(_formKey.currentState?.validate() ?? false)) return;
    }

    const applicant = ApplicantDetails(
      name: 'اميرة عصام حامد',
      nationalId: '010123456789099',
      phone: '01013706488',
      email: 'amirabadreldeen7@icloud.com',
    );

    final String paymentMethodLabel =
        selectedMethod == VehicleDeliveryMethod.delivery
            ? 'التوصيل للعنوان'
            : 'الاستلام من وحدة المرور';

    final String orderTypeLabel =
        widget.replacementType == VehicleReplacementType.lost
            ? 'بدل فاقد رخصة مركبة'
            : 'بدل تالف رخصة مركبة';

    final orderSummary = OrderSummary(
      orderType: orderTypeLabel,
      paymentMethod: paymentMethodLabel,
      orderId: widget.vehicle.plateNumber,
    );

    final fees = FeesDetails(
      items: [
        const FeeItem(label: 'رسوم اصدار الرخصة', amount: '280 جنيه مصري'),
        if (selectedMethod == VehicleDeliveryMethod.delivery)
          const FeeItem(label: 'رسوم شحن الرخصة', amount: '80 جنيه مصري'),
        const FeeItem(label: 'رسوم الفحص', amount: '80 جنيه مصري'),
      ],
      total: selectedMethod == VehicleDeliveryMethod.delivery
          ? '440 جنيه مصري'
          : '360 جنيه مصري',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GenericOrderReviewScreen(
          appBarTitle: 'اصدار بدل فاقد / تالف رخصة مركبة',
          applicantDetails: applicant,
          orderSummary: orderSummary,
          feesDetails: fees,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            const ServiceScreenAppBar(title: 'اصدار بدل فاقد / تالف رخصة مركبة'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'طريقة استلام الرخصة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF222222),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SelectionOptionCard(
                        title: 'استلام من وحدة المرور',
                        subtitle:
                            'استلم الرخصة شخصيًا من وحدة المرور التي تم تسجيلها في بياناتك',
                        isSelected: selectedMethod == VehicleDeliveryMethod.pickup,
                        onTap: () =>
                            setState(() => selectedMethod = VehicleDeliveryMethod.pickup),
                        icon: Icon(Icons.account_balance_outlined,
                            color: const Color(0xFF27AE60), size: 22.r),
                      ),
                      SizedBox(height: 12.h),
                      SelectionOptionCard(
                        title: 'التوصيل للعنوان',
                        subtitle:
                            'سيتم توصيل رخصتك الجديدة للعنوان الذي تحدده, يرجى التأكد من صحة العنوان لتجنب أي تأخير.',
                        isSelected: selectedMethod == VehicleDeliveryMethod.delivery,
                        onTap: () => setState(
                            () => selectedMethod = VehicleDeliveryMethod.delivery),
                        icon: Icon(Icons.home_outlined,
                            color: const Color(0xFF27AE60), size: 22.r),
                      ),
                      if (selectedMethod == VehicleDeliveryMethod.delivery) ...[
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          labelText: 'المحافظة',
                          hintText: 'اكتب المحافظة',
                          controller: _governorateController,
                          validator: (v) => v?.isEmpty ?? true
                              ? 'برجاء إدخال اسم محافظة صحيح'
                              : null,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          labelText: 'المدينة / المركز',
                          hintText: 'اكتب المدينة / المركز',
                          controller: _cityController,
                          validator: (v) => v?.isEmpty ?? true
                              ? 'برجاء إدخال اسم مدينة / مركز صحيح'
                              : null,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          labelText: 'تفاصيل إضافية للعنوان',
                          hintText: 'اكتب تفاصيل العنوان....',
                          controller: _addressDetailsController,
                          validator: (v) => v?.isEmpty ?? true
                              ? 'تعذر التحقق من العنوان…برجاء كتابة العنوان بشكل أوضح'
                              : null,
                          minLines: 3,
                          maxLines: 5,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: PrimaryButton(
                label: 'التالي',
                onPressed: _isButtonEnabled ? _onNextPressed : null,
                height: 48.h,
                backgroundColor: const Color(0xFF27AE60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
