import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/checkout/generic_order_review_screen.dart';
import 'package:traffic/core/features/checkout/models/applicant_details.dart';
import 'package:traffic/core/features/checkout/models/fees_details.dart';
import 'package:traffic/core/features/checkout/models/order_summary.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/violations_inquiry/data/models/license_model.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/selection_option_card.dart';
import 'replacement_type_selection_screen.dart';

// ── Enum ──────────────────────────────────────────────────────────────────────

/// Represents how the user wants to receive their replacement licence.
enum DeliveryMethod {
  /// Collect in person from the traffic unit (استلام من وحدة المرور).
  pickup,

  /// Deliver to a home address (التوصيل للعنوان).
  delivery,
}

// ── Screen ────────────────────────────────────────────────────────────────────

/// **Licence Delivery Method Screen** — Step 4 of the
/// "Lost / Damaged Driving Licence" flow.
///
/// Behaviour summary:
/// | selectedMethod | Form visible | Button state        |
/// |----------------|--------------|---------------------|
/// | null           | No           | Disabled (grey)     |
/// | pickup         | No           | Active → proceeds   |
/// | delivery       | Yes (3 fields)| Active only if form valid |
class DeliveryMethodScreen extends StatefulWidget {
  /// The licence chosen in Step 1 (License Selection).
  final DrivingLicenseModel license;

  /// The replacement type chosen in Step 3 (بدل فاقد / بدل تالف).
  final ReplacementType replacementType;

  const DeliveryMethodScreen({
    super.key,
    required this.license,
    required this.replacementType,
  });

  @override
  State<DeliveryMethodScreen> createState() => _DeliveryMethodScreenState();
}

class _DeliveryMethodScreenState extends State<DeliveryMethodScreen> {
  // ── State ─────────────────────────────────────────────────────────────────

  /// Currently selected delivery method; `null` until the user picks one.
  DeliveryMethod? selectedMethod;

  final _formKey = GlobalKey<FormState>();

  // ── Controllers ───────────────────────────────────────────────────────────

  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressDetailsController =
      TextEditingController();

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _governorateController.dispose();
    _cityController.dispose();
    _addressDetailsController.dispose();
    super.dispose();
  }

  // ── Derived state ─────────────────────────────────────────────────────────

  /// The "التالي" button is enabled only when a method is selected.
  /// For delivery, the form must also be valid before proceeding — that is
  /// enforced inside [_onNextPressed] via [_formKey.currentState!.validate()].
  bool get _isButtonEnabled => selectedMethod != null;

  // ── Handlers ──────────────────────────────────────────────────────────────

  void _onMethodTap(DeliveryMethod method) {
    setState(() => selectedMethod = method);
  }

  void _onNextPressed() {
    // ── Build shared data objects ────────────────────────────────────────────
    // Applicant details are currently mocked (no auth layer yet).
    const applicant = ApplicantDetails(
      name: 'اميرة عصام حامد',
      nationalId: '010123456789099',
      phone: '01013706488',
      email: 'amirabadreldeen7@icloud.com',
    );

    // Determine the payment / delivery label from the user's current choice.
    final String paymentMethodLabel = selectedMethod == DeliveryMethod.delivery
        ? 'التوصيل للعنوان'
        : 'الاستلام من وحدة المرور';

    // Derive the order-type label from the replacement type.
    final String orderTypeLabel = widget.replacementType == ReplacementType.lost
        ? 'بدل فاقد رخصة قيادة'
        : 'بدل تالف رخصة قيادة';

    final orderSummary = OrderSummary(
      orderType: orderTypeLabel,
      paymentMethod: paymentMethodLabel,
      orderId: widget.license.licenseNumber,
    );

    const fees = FeesDetails(
      items: [
        FeeItem(label: 'رسوم اصدار الرخصة', amount: '280 جنيه مصري'),
        FeeItem(label: 'رسوم شحن الرخصة', amount: '80 جنيه مصري'),
        FeeItem(label: 'رسوم الفحص', amount: '80 جنيه مصري'),
      ],
      total: '440 جنيه مصري',
    );

    // Validate address fields only when delivery is selected.
    if (selectedMethod == DeliveryMethod.delivery) {
      if (!(_formKey.currentState?.validate() ?? false)) return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GenericOrderReviewScreen(
          appBarTitle: 'اصدار بدل فاقد / تالف رخصة قيادة',
          applicantDetails: applicant,
          orderSummary: orderSummary,
          feesDetails: fees,
        ),
      ),
    );
  }

  // ── Validators ────────────────────────────────────────────────────────────

  String? _validateGovernorate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'برجاء إدخال اسم محافظة صحيح';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'برجاء إدخال اسم مدينة / مركز صحيح';
    }
    return null;
  }

  String? _validateAddressDetails(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'تعذر التحقق من العنوان…برجاء كتابة العنوان بشكل أوضح';
    }
    return null;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final bool isDelivery = selectedMethod == DeliveryMethod.delivery;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // ── App bar ────────────────────────────────────────────────────
            ServiceScreenAppBar(title: 'اصدار بدل فاقد / تالف رخصة قيادة'),

            // ── Scrollable body ────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Section header ──────────────────────────────────
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

                      // ── Option 1: استلام من وحدة المرور (pickup) ─────────
                      SelectionOptionCard(
                        title: 'استلام من وحدة المرور',
                        subtitle:
                            'استلم الرخصة شخصيًا من وحدة المرور التي تم تسجيلها في بياناتك',
                        isSelected: selectedMethod == DeliveryMethod.pickup,
                        onTap: () => _onMethodTap(DeliveryMethod.pickup),
                        icon: Icon(
                          Icons.account_balance_outlined,
                          color: const Color(0xFF27AE60),
                          size: 22.r,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // ── Option 2: التوصيل للعنوان (delivery) ─────────────
                      SelectionOptionCard(
                        title: 'التوصيل للعنوان',
                        subtitle:
                            'سيتم توصيل رخصتك الجديدة للعنوان الذي تحدده, يرجى التأكد من صحة العنوان لتجنب أي تأخير.',
                        isSelected: selectedMethod == DeliveryMethod.delivery,
                        onTap: () => _onMethodTap(DeliveryMethod.delivery),
                        icon: Icon(
                          Icons.home_outlined,
                          color: const Color(0xFF27AE60),
                          size: 22.r,
                        ),
                      ),

                      // ── Delivery address form (animated in/out) ──────────
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: isDelivery
                            ? _DeliveryAddressForm(
                                governorateController: _governorateController,
                                cityController: _cityController,
                                addressDetailsController:
                                    _addressDetailsController,
                                validateGovernorate: _validateGovernorate,
                                validateCity: _validateCity,
                                validateAddressDetails: _validateAddressDetails,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Sticky bottom button ───────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: PrimaryButton(
                label: 'التالي',
                onPressed: _isButtonEnabled ? _onNextPressed : null,
                height: 48.h,
                backgroundColor: const Color(0xFF27AE60),
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widget ────────────────────────────────────────────────────────

/// The three address fields shown only when "التوصيل للعنوان" is selected.
/// Extracted as a private widget to keep [_DeliveryMethodScreenState.build]
/// readable.
class _DeliveryAddressForm extends StatelessWidget {
  final TextEditingController governorateController;
  final TextEditingController cityController;
  final TextEditingController addressDetailsController;
  final FormFieldValidator<String> validateGovernorate;
  final FormFieldValidator<String> validateCity;
  final FormFieldValidator<String> validateAddressDetails;

  const _DeliveryAddressForm({
    required this.governorateController,
    required this.cityController,
    required this.addressDetailsController,
    required this.validateGovernorate,
    required this.validateCity,
    required this.validateAddressDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),

        // ── Governorate ──────────────────────────────────────────────────
        CustomTextFormField(
          labelText: 'المحافظة',
          hintText: 'اكتب المحافظة',
          controller: governorateController,
          validator: validateGovernorate,
        ),

        SizedBox(height: 16.h),

        // ── City / District ──────────────────────────────────────────────
        CustomTextFormField(
          labelText: 'المدينة / المركز',
          hintText: 'اكتب المدينة / المركز',
          controller: cityController,
          validator: validateCity,
        ),

        SizedBox(height: 16.h),

        // ── Additional address details (multiline textarea) ───────────────
        CustomTextFormField(
          labelText: 'تفاصيل إضافية للعنوان',
          hintText: 'اكتب تفاصيل العنوان....',
          controller: addressDetailsController,
          validator: validateAddressDetails,
          minLines: 3,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
        ),

        SizedBox(height: 8.h),
      ],
    );
  }
}
