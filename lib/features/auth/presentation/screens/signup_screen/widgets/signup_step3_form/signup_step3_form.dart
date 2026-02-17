import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/constants/app_sizes.dart';
import 'widgets/form_title_widget.dart';
import 'widgets/field_label_widget.dart';
import 'widgets/password_field_widget.dart';
import 'widgets/password_requirements_list_widget.dart';
import 'widgets/navigation_buttons_widget.dart';

class SignupStep3Form extends StatelessWidget {
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final ValueChanged<String> onPasswordChanged;
  final bool hasMinLength;
  final bool hasLetter;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool notSameAsUsername;
  final VoidCallback onNextPressed;
  final VoidCallback onPreviousPressed;
  final bool isValid;

  const SignupStep3Form({
    super.key,
    required this.passwordController,
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.onPasswordChanged,
    required this.hasMinLength,
    required this.hasLetter,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.notSameAsUsername,
    required this.onNextPressed,
    required this.onPreviousPressed,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = context.buttonHeightS;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const FormTitleWidget(title: 'أنشئ كلمة المرور الخاصة بك'),
            SizedBox(height: 20.h),
            const FieldLabelWidget(label: 'أنشئ كلمة المرور'),
            SizedBox(height: 5.h),
            PasswordFieldWidget(
              controller: passwordController,
              obscurePassword: obscurePassword,
              onToggleObscure: onToggleObscure,
              onChanged: onPasswordChanged,
            ),
            SizedBox(height: 20.h),
            // Password requirements
            PasswordRequirementsListWidget(
              hasMinLength: hasMinLength,
              hasLetter: hasLetter,
              hasNumber: hasNumber,
              hasSpecialChar: hasSpecialChar,
              notSameAsUsername: notSameAsUsername,
            ),
            SizedBox(height: 0.08.sh),
            // Buttons
            NavigationButtonsWidget(
              onNextPressed: onNextPressed,
              onPreviousPressed: onPreviousPressed,
              isValid: isValid,
              buttonHeight: buttonHeight,
            ),
          ],
        ),
      ),
    );
  }
}
