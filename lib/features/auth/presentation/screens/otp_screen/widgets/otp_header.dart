import 'package:flutter/material.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_styles.dart';

/// Header section with instruction texts and masked email.
class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key, required this.maskedEmail});

  final String maskedEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: OtpStyles.horizontalPadding),
      child: Column(
        children: [
          Text(
            'تم إرسال رمز مكون من 4 أرقام إلى بريدك الالكتروني',
            style: OtpStyles.instructionStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: OtpStyles.emailToInstructionSpacing),
          Text(
            maskedEmail,
            style: OtpStyles.emailStyle,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
          SizedBox(height: OtpStyles.instructionToConfirmSpacing),
          Text(
            'أدخل الرمز لتأكيد هويتك ومتابعة العملية.',
            style: OtpStyles.confirmInstructionStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
