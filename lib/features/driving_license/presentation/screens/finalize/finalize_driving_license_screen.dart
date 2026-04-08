import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/spacing.dart';
import '../../../../../core/widgets/app_drawer.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/widgets/service_screen_appbar.dart';
import '../../../../lost_license/presentation/widgets/custom_text_form_field.dart';
import '../../../../lost_license/presentation/widgets/selection_option_card.dart';
import '../../cubits/driving_license_cubit.dart';
import '../../cubits/driving_license_state.dart';

class FinalizeDrivingLicenseScreen extends StatefulWidget {
  final String requestNumber;

  const FinalizeDrivingLicenseScreen({
    super.key,
    required this.requestNumber,
  });

  @override
  State<FinalizeDrivingLicenseScreen> createState() =>
      _FinalizeDrivingLicenseScreenState();
}

class _FinalizeDrivingLicenseScreenState
    extends State<FinalizeDrivingLicenseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // 1: TrafficUnit (pickup), 2: HomeDelivery (delivery)
  int? _deliveryMethod;
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

  void _onFinalize(BuildContext context) {
    if (_deliveryMethod == 2) {
      if (!(_formKey.currentState?.validate() ?? false)) return;
    }

    context.read<DrivingLicenseCubit>().finalizeDrivingLicense(
          requestNumber: widget.requestNumber,
          method: _deliveryMethod ?? 1,
          governorate: _deliveryMethod == 2 ? _governorateController.text : null,
          city: _deliveryMethod == 2 ? _cityController.text : null,
          details: _deliveryMethod == 2 ? _addressDetailsController.text : null,
        );
  }

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

  @override
  Widget build(BuildContext context) {
    final bool isDelivery = _deliveryMethod == 2;
    final bool isButtonEnabled = _deliveryMethod != null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF5F5F5),
        drawer: const AppDrawer(),
        body: BlocConsumer<DrivingLicenseCubit, DrivingLicenseState>(
          listener: (context, state) {
            if (state is DrivingLicenseFinalizeSuccess) {
              _showSuccessDialog(context, state.license.drivingLicenseNumber);
            } else if (state is DrivingLicenseFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message, textDirection: TextDirection.rtl),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is DrivingLicenseLoading;

            return Column(
              children: [
                ServiceScreenAppBar(
                  title: 'استكمال الطلب',
                  onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                            isSelected: _deliveryMethod == 1,
                            onTap: () => setState(() => _deliveryMethod = 1),
                            icon: Icon(
                              Icons.account_balance_outlined,
                              color: const Color(0xFF27AE60),
                              size: 22.r,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SelectionOptionCard(
                            title: 'التوصيل للعنوان',
                            subtitle:
                                'سيتم توصيل رخصتك الجديدة للعنوان الذي تحدده, يرجى التأكد من صحة العنوان لتجنب أي تأخير.',
                            isSelected: _deliveryMethod == 2,
                            onTap: () => setState(() => _deliveryMethod = 2),
                            icon: Icon(
                              Icons.home_outlined,
                              color: const Color(0xFF27AE60),
                              size: 22.r,
                            ),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: isDelivery
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: 20.h),
                                      CustomTextFormField(
                                        labelText: 'المحافظة',
                                        hintText: 'اكتب المحافظة',
                                        controller: _governorateController,
                                        validator: _validateGovernorate,
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextFormField(
                                        labelText: 'المدينة / المركز',
                                        hintText: 'اكتب المدينة / المركز',
                                        controller: _cityController,
                                        validator: _validateCity,
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextFormField(
                                        labelText: 'تفاصيل إضافية للعنوان',
                                        hintText: 'اكتب تفاصيل العنوان....',
                                        controller: _addressDetailsController,
                                        validator: _validateAddressDetails,
                                        minLines: 3,
                                        maxLines: 5,
                                        keyboardType: TextInputType.multiline,
                                      ),
                                      SizedBox(height: 8.h),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          label: 'إنهاء وإصدار الرخصة',
                          onPressed: isButtonEnabled
                              ? () => _onFinalize(context)
                              : null,
                          height: 48.h,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String licenseNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        title: Text(
          'تم إصدار الرخصة بنجاح',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              fontSize: 20.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline,
                color: AppColors.primary, size: 64.w),
            SizedBox(height: Insets.x16.h),
            Text(
              'رقم الرخصة: $licenseNumber',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  fontSize: 16.sp),
            ),
            SizedBox(height: Insets.x12.h),
            Text(
              'تم تفعيل رخصة القيادة الخاصة بك. يمكنك عرضها من خلال شاشة التراخيص.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.textSecondary,
                  fontFamily: 'Tajawal',
                  fontSize: 14.sp),
            ),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: SizedBox(
                width: 150.w,
                child: PrimaryButton(
                  label: 'العودة للرئيسية',
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
