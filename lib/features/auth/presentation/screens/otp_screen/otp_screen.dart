import 'package:flutter/material.dart';
import 'package:traffic/core/widgets/custom_appbar.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_controller.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_styles.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/widgets/otp_header.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/widgets/otp_inputs_row.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/widgets/otp_success_sheet.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/widgets/otp_timer_resend.dart';

/// OTP verification screen with three states: initial, error, and success.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  /// Email passed from Signup Step 1 (will be masked for display)
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late OtpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OtpController(email: widget.email);
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (_controller.isSuccess) {
      _showSuccessSheet();
      // Remove listener to prevent multiple sheets
      _controller.removeListener(_onControllerChanged);
    }
    setState(() {});
  }

  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      barrierColor: OtpStyles.barrierColor,
      builder: (context) => const OtpSuccessSheet(),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: OtpStyles.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: OtpStyles.horizontalPadding,
                ),
                child: CustomAppbar(
                  title: "أدخل رمز التحقق",
                  onBackPressed: () => Navigator.pop(context),
                ),
              ),

              SizedBox(height: OtpStyles.appBarToTextSpacing),

              // Instruction text
              OtpHeader(maskedEmail: _controller.maskedEmail),

              SizedBox(height: OtpStyles.textToInputSpacing),

              // OTP Input Row
              OtpInputsRow(controller: _controller),

              // Error message
              if (_controller.showError) ...[
                SizedBox(height: OtpStyles.errorMessageSpacing),
                Text(
                  'الرمز خاطئ يرجى المحاولة مرة اخرى',
                  style: OtpStyles.errorMessageStyle,
                  textAlign: TextAlign.center,
                ),
              ],

              SizedBox(height: OtpStyles.inputToTimerSpacing),

              // Timer and Resend
              OtpTimerResend(
                formattedTimer: _controller.formattedTimer,
                canResend: _controller.canResend,
                onResend: _controller.resendOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
