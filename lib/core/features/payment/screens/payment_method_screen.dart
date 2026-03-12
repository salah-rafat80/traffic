import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/payment/models/payment_intent.dart';
import 'package:traffic/core/features/payment/screens/credit_card_entry_screen.dart';
import 'package:traffic/core/features/payment/widgets/payment_option_card.dart';
import 'package:traffic/core/features/payment/widgets/payment_summary_card.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';

class PaymentMethodScreen extends StatefulWidget {
  final PaymentIntent paymentIntent;

  const PaymentMethodScreen({super.key, required this.paymentIntent});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // For this design, we only have one option, so it can start selected.
  bool _isVisaSelected = true;

  void _onNextPressed() {
    if (_isVisaSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              CreditCardEntryScreen(paymentIntent: widget.paymentIntent),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // App bar
            ServiceScreenAppBar(title: widget.paymentIntent.orderType),

            // Scrollable body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
                      logoAssetPath:
                          'assets/visa_mc_logo.png', // Temporary placeholder
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: PrimaryButton(
                label: 'التالي',
                onPressed: _isVisaSelected ? _onNextPressed : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
