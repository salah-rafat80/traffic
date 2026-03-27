import 'package:flutter/material.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_controller.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_styles.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/widgets/otp_input_box.dart';

/// Row containing the 4 OTP input boxes.
class OtpInputsRow extends StatelessWidget {
  const OtpInputsRow({super.key, required this.controller});

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : OtpStyles.inputBoxSpacing,
            ),
            child: OtpInputBox(
              controller: controller.controllers[index],
              focusNode: controller.focusNodes[index],
              hasError: controller.showError,
              onChanged: (value) => controller.onOtpChanged(index, value),
              onBackspace: () => controller.handleBackspace(index),
            ),
          );
        }),
      ),
    );
  }
}
