import 'package:flutter/material.dart';
import '../widgets/signup_app_bar.dart';
import '../widgets/custom_text_field.dart';
import 'signup_step3_screen.dart';

class SignupStep2Screen extends StatefulWidget {
  final String username;
  final String email;
  final String phone;

  const SignupStep2Screen({
    super.key,
    required this.username,
    required this.email,
    required this.phone,
  });

  @override
  State<SignupStep2Screen> createState() => _SignupStep2ScreenState();
}

class _SignupStep2ScreenState extends State<SignupStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final _nationalIdController = TextEditingController();

  String? _nationalIdError;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _familyNameController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      _nationalIdError = null;
    });

    bool isValid = true;

    // Validate national ID (should be 14 digits in Egypt)
    if (_nationalIdController.text.isEmpty ||
        _nationalIdController.text.length != 14 ||
        !RegExp(r'^\d+$').hasMatch(_nationalIdController.text)) {
      setState(() {
        _nationalIdError = 'الرجاء ادخال رقم قومي صحيح.';
      });
      isValid = false;
    }

    if (_firstNameController.text.isEmpty ||
        _familyNameController.text.isEmpty) {
      isValid = false;
    }

    return isValid;
  }

  bool get _isFormValid {
    return _firstNameController.text.isNotEmpty &&
        _familyNameController.text.isNotEmpty &&
        _nationalIdController.text.isNotEmpty &&
        _acceptedTerms;
  }

  void _onNextPressed() {
    if (_validateFields()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupStep3Screen(
            username: widget.username,
            email: widget.email,
            phone: widget.phone,
            firstName: _firstNameController.text,
            familyName: _familyNameController.text,
            nationalId: _nationalIdController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SignupAppBar(
        step: '2 من 3',
        nextStepText: 'التالي : أنشئ كلمة المرور الخاصة بك',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8),
                  // Title
                  const Text(
                    'البيانات الشخصية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 32),
                  // First name field
                  const Text(
                    'الاسم الأول',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _firstNameController,
                    hintText: 'أميرة',
                    textAlign: TextAlign.right,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 24),
                  // Family name field
                  const Text(
                    'اسم العائلة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _familyNameController,
                    hintText: 'بدر',
                    textAlign: TextAlign.right,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 24),
                  // National ID field
                  const Text(
                    'الرقم القومي',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _nationalIdController,
                    hintText: '1234567890-',
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    hasError: _nationalIdError != null,
                    maxLength: 14,
                    onChanged: (_) {
                      if (_nationalIdError != null) {
                        setState(() => _nationalIdError = null);
                      }
                      setState(() {});
                    },
                  ),
                  if (_nationalIdError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _nationalIdError!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFD32F2F),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  // Terms checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'اوافق على جميع الشروط والاحكام',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _acceptedTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptedTerms = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFF27AE60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.1),
                  // Buttons
                  Row(
                    children: [
                      // Next button - LEFT side
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isFormValid ? _onNextPressed : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFormValid
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
      ),
    );
  }
}
