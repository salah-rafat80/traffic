import 'package:flutter/material.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_styles.dart';

/// Timer display and resend button section.
class OtpTimerResend extends StatelessWidget {
  const OtpTimerResend({
    super.key,
    required this.formattedTimer,
    required this.canResend,
    required this.onResend,
  });

  final String formattedTimer;
  final bool canResend;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timer
        Text(formattedTimer, style: OtpStyles.timerStyle),
        SizedBox(height: OtpStyles.timerToResendSpacing),
        // Resend section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('لم أتلق أي رمز', style: OtpStyles.noCodeReceivedStyle),
            SizedBox(width: OtpStyles.resendTextSpacing),
            GestureDetector(
              onTap: canResend ? onResend : null,
              child: Text(
                'إعادة الإرسال',
                style: OtpStyles.resendStyle(enabled: canResend),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
