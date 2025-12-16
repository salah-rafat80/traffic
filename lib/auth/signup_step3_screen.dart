import 'package:flutter/material.dart';
import '../widgets/signup_app_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_requirement_item.dart';

class SignupStep3Screen extends StatefulWidget {
  final String username;
  final String email;
  final String phone;
  final String firstName;
  final String familyName;
  final String nationalId;

  const SignupStep3Screen({
    super.key,
    required this.username,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.familyName,
    required this.nationalId,
  });

  @override
  State<SignupStep3Screen> createState() => _SignupStep3ScreenState();
}

class _SignupStep3ScreenState extends State<SignupStep3Screen> {
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Password requirements
  bool _hasMinLength = false;
  bool _hasLetter = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _notSameAsUsername = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPasswordRequirements(String password) {
    setState(() {
      // At least 8 characters
      _hasMinLength = password.length >= 8;

      // Contains at least one letter (a-z, A-Z)
      _hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);

      // Contains at least one number (0-9)
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);

      // Contains at least one special character
      _hasSpecialChar = RegExp(
        r'''[!@#$%^&*()_+\-=\[\]{};:'",.<>/?\\|`~]''',
      ).hasMatch(password);

      // Not the same as username
      _notSameAsUsername =
          password.toLowerCase() != widget.username.toLowerCase();
    });
  }

  bool get _allRequirementsMet {
    return _hasMinLength &&
        _hasLetter &&
        _hasNumber &&
        _hasSpecialChar &&
        _notSameAsUsername;
  }

  void _onNextPressed() {
    if (_allRequirementsMet) {
      // TODO: Submit signup data
      // For now, just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء الحساب بنجاح',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: 'Tajawal'),
          ),
          backgroundColor: Color(0xFF27AE60),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SignupAppBar(step: '3 من 3'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8),
                // Title
                const Text(
                  'أنشئ كلمة المرور الخاصة بك',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Tajawal',
                  ),
                ),
                const SizedBox(height: 32),
                // Subtitle
                const Text(
                  'أنشئ كلمة المرور',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Tajawal',
                  ),
                ),
                const SizedBox(height: 8),
                // Password field
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Amira297',
                  textAlign: TextAlign.right,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF27AE60),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  onChanged: _checkPasswordRequirements,
                ),
                const SizedBox(height: 32),
                // Password requirements
                PasswordRequirementItem(
                  text: '8 أحرف على الأقل',
                  isMet: _hasMinLength,
                ),
                PasswordRequirementItem(
                  text: 'تحتوي على حرف واحد على الأقل (a-z ,A-Z)',
                  isMet: _hasLetter,
                ),
                PasswordRequirementItem(
                  text: 'تحتوي على رقم واحد على الأقل (0-9)',
                  isMet: _hasNumber,
                ),
                PasswordRequirementItem(
                  text:
                      'تحتوي على رمز خاص واحد على الأقل\n~ } { ] [ ? ; , : " \\ > < + _ ) * & ^ % \$ # @ !',
                  isMet: _hasSpecialChar,
                ),
                PasswordRequirementItem(
                  text: 'يجب أن تكون كلمة المرور مختلفة عن اسم المستخدم',
                  isMet: _notSameAsUsername,
                ),
                SizedBox(height: size.height * 0.08),
                // Buttons
                Row(
                  children: [
                    // Next button - LEFT side
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _allRequirementsMet
                              ? _onNextPressed
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _allRequirementsMet
                                ? const Color(0xFF27AE60)
                                : const Color(0xFFBDBDBD),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFFBDBDBD),
                            disabledForegroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'التالي',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Previous button - RIGHT side
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF27AE60),
                            side: const BorderSide(
                              color: Color(0xFF27AE60),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'السابق',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
