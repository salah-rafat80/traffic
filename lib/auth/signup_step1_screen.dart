import 'package:flutter/material.dart';
import '../widgets/signup_app_bar.dart';
import '../widgets/custom_text_field.dart';
import 'signup_step2_screen.dart';

class SignupStep1Screen extends StatefulWidget {
  const SignupStep1Screen({super.key});

  @override
  State<SignupStep1Screen> createState() => _SignupStep1ScreenState();
}

class _SignupStep1ScreenState extends State<SignupStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _usernameError;
  String? _emailError;
  String? _phoneError;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      _usernameError = null;
      _emailError = null;
      _phoneError = null;
    });

    bool isValid = true;

    // Validate username
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'الرجاء ادخال اسم مستخدم صحيح.';
      });
      isValid = false;
    }

    // Validate email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_emailController.text.isEmpty ||
        !emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _emailError = 'الرجاء ادخال عنوان بريد الكتروني صحيح.';
      });
      isValid = false;
    }

    // Validate phone
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      setState(() {
        _phoneError = 'الرجاء ادخال رقم هاتف صحيح.';
      });
      isValid = false;
    }

    return isValid;
  }

  void _onNextPressed() {
    if (_validateFields()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupStep2Screen(
            username: _usernameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SignupAppBar(
        step: '1 من 3',
        nextStepText: 'التالي : البيانات الشخصية',
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
                    'معلومات التواصل',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Username field
                  const Text(
                    'اسم المستخدم',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _usernameController,
                    hintText: 'amaa',
                    textAlign: TextAlign.right,
                    hasError: _usernameError != null,
                    onChanged: (_) {
                      if (_usernameError != null) {
                        setState(() => _usernameError = null);
                      }
                    },
                  ),
                  if (_usernameError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _usernameError!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFD32F2F),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  // Email field
                  const Text(
                    'البريد الإلكتروني',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'amira@234567',
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.emailAddress,
                    hasError: _emailError != null,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                  ),
                  if (_emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _emailError!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFD32F2F),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  // Phone field
                  const Text(
                    'رقم الهاتف',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Phone number (LEFT side)
                      Expanded(
                        child: CustomTextField(
                          controller: _phoneController,
                          hintText: '1234567',
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.phone,
                          hasError: _phoneError != null,
                          onChanged: (_) {
                            if (_phoneError != null) {
                              setState(() => _phoneError = null);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Country code (RIGHT side)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _phoneError != null
                                ? const Color(0xFFD32F2F)
                                : const Color(0xFF27AE60),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '+20',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_phoneError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _phoneError!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFD32F2F),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  SizedBox(height: size.height * 0.15),
                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF27AE60),
                        foregroundColor: Colors.white,
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
