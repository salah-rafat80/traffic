import 'package:flutter/material.dart';
import 'package:traffic/core/widgets/password_requirement_item.dart';

class PasswordRequirementsListWidget extends StatelessWidget {
  final bool hasMinLength;
  final bool hasLetter;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool notSameAsUsername;

  const PasswordRequirementsListWidget({
    super.key,
    required this.hasMinLength,
    required this.hasLetter,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.notSameAsUsername,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordRequirementItem(text: '8 أحرف على الأقل', isMet: hasMinLength),
        PasswordRequirementItem(
          text: 'تحتوي على حرف واحد على الأقل (a-z ,A-Z)',
          isMet: hasLetter,
        ),
        PasswordRequirementItem(
          text: 'تحتوي على رقم واحد على الأقل (0-9)',
          isMet: hasNumber,
        ),
        PasswordRequirementItem(
          text:
              'تحتوي على رمز خاص واحد على الأقل\n! @ # \$ % ^ & * ( ) _ + - = [ ] { } ; : \' " \\ | , . < > / ?',
          isMet: hasSpecialChar,
        ),
        PasswordRequirementItem(
          text: 'يجب ألا تكون كلمة المرور مطابقة عن اسم المستخدم',
          isMet: notSameAsUsername,
        ),
      ],
    );
  }
}
