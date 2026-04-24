import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/features/payment/data/repositories/payment_repository.dart';
import 'package:traffic/core/features/payment/presentation/cubits/payment_cubit.dart';
import 'package:traffic/core/features/payment/presentation/cubits/payment_state.dart';
import 'package:traffic/core/features/payment/models/payment_intent.dart';
import 'package:traffic/core/features/payment/screens/payment_webview_screen.dart';
import 'package:traffic/core/features/payment/widgets/payment_option_card.dart';
import 'package:traffic/core/features/payment/widgets/payment_summary_card.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';

class PaymentMethodScreen extends StatelessWidget {
  final PaymentIntent paymentIntent;

  const PaymentMethodScreen({super.key, required this.paymentIntent});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(PaymentRepository(ApiClient())),
      child: _PaymentMethodScreenContent(paymentIntent: paymentIntent),
    );
  }
}

class _PaymentMethodScreenContent extends StatefulWidget {
  final PaymentIntent paymentIntent;

  const _PaymentMethodScreenContent({required this.paymentIntent});

  @override
  State<_PaymentMethodScreenContent> createState() =>
      _PaymentMethodScreenContentState();
}

class _PaymentMethodScreenContentState extends State<_PaymentMethodScreenContent> {
  bool _isVisaSelected = true;
  DateTime? _lastClickTime;

  void _onNextPressed(BuildContext context) {
    final now = DateTime.now();
    developer.log('Button Click Timestamp: $now', name: 'PaymentMethodScreen');

    if (_lastClickTime != null && now.difference(_lastClickTime!) < const Duration(seconds: 2)) {
      developer.log('Ignored duplicate button click (debounced)', name: 'PaymentMethodScreen');
      return;
    }
    _lastClickTime = now;

    if (_isVisaSelected) {
      if (widget.paymentIntent.serviceRequestNumber == null ||
          widget.paymentIntent.serviceRequestNumber!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('رقم الطلب غير متاح')),
        );
        return;
      }
      developer.log('Initiating payment for: ${widget.paymentIntent.serviceRequestNumber}', name: 'PaymentMethodScreen');
      context.read<PaymentCubit>().initiatePayment(
            widget.paymentIntent.serviceRequestNumber!,
          );
    }
  }

  void _handlePaymentResult(dynamic result) {
    if (result != null && result is Map<String, dynamic>) {
      final isSuccess = result['paymentSuccess'] == true;
      if (isSuccess) {
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إلغاء عملية الدفع أو فشلت',
                textDirection: TextDirection.rtl),
            backgroundColor: Color(0xFFE53935),
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        title: Text(
          'تم الدفع بنجاح',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
            fontSize: 20.sp,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline,
                color: const Color(0xFF27AE60), size: 64.w),
            SizedBox(height: 16.h),
            Text(
              'تم استلام المبلغ بنجاح، وتأكيد طلبك.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF444444),
                fontFamily: 'Tajawal',
                fontSize: 14.sp,
              ),
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) async {
            developer.log('State Transition: ${state.runtimeType}', name: 'PaymentMethodScreen');
            if (state is PaymentInitSuccess) {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentWebviewScreen(
                    paymentUrl: state.response.paymentUrl,
                    merchantOrderId: state.response.merchantOrderId,
                    paymentId: state.response.paymentId.toString(),
                    requestNumber: widget.paymentIntent.serviceRequestNumber,
                  ),
                ),
              );
              _handlePaymentResult(result);
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(state.message, textDirection: TextDirection.rtl),
                  backgroundColor: const Color(0xFFE53935),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is PaymentLoading;

            return Column(
              children: [
                // App bar
                ServiceScreenAppBar(title: widget.paymentIntent.orderType),

                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section title
                        Text(
                          'تأكيد وسيلة دفع',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF222222),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Summary card
                        PaymentSummaryCard(paymentIntent: widget.paymentIntent),
                        SizedBox(height: 16.h),

                        // Payment option (Visa/MC)
                        PaymentOptionCard(
                          title: 'فيزا/ ماستر كارد',
                          subtitle: 'Visa/Mastercard',
                          logoAssetPath: 'assets/visa_mc_logo.png',
                          isSelected: _isVisaSelected,
                          onTap: () {
                            setState(() {
                              _isVisaSelected = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom action
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF27AE60)))
                      : PrimaryButton(
                          label: 'التالي',
                          onPressed: _isVisaSelected
                              ? () => _onNextPressed(context)
                              : null,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
