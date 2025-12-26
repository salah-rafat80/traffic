import 'package:flutter/material.dart';
import 'package:traffic/core/widgets/signup_app_bar.dart';
import 'widgets/signup_step1_form.dart';
import 'widgets/signup_step2_form.dart';
import 'widgets/signup_step3_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1 controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Step 2 controllers
  final _firstNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  bool _acceptedTerms = false;

  // Step 3 controllers
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Validation errors
  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _nationalIdError;

  // Password requirements
  bool _hasMinLength = false;
  bool _hasLetter = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _notSameAsUsername = true;

  @override
  void dispose() {
    _pageController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _familyNameController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _stepText {
    return '${_currentStep + 1} من 3';
  }

  String? get _nextStepText {
    switch (_currentStep) {
      case 0:
        return 'التالي : البيانات الشخصية';
      case 1:
        return 'التالي : أنشئ كلمة المرور الخاصة بك';
      default:
        return null;
    }
  }

  void _goToNextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // Step 1 validation
  bool _validateStep1() {
    setState(() {
      _usernameError = null;
      _emailError = null;
      _phoneError = null;
    });

    bool isValid = true;

    if (_usernameController.text.isEmpty) {
      setState(() => _usernameError = 'الرجاء إدخال اسم مستخدم صحيح');
      isValid = false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_emailController.text.isEmpty ||
        !emailRegex.hasMatch(_emailController.text)) {
      setState(() => _emailError = 'الرجاء إدخال عنوان بريد إلكتروني صحيح');
      isValid = false;
    }

    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      setState(() => _phoneError = 'الرجاء إدخال رقم هاتف صحيح');
      isValid = false;
    }

    return isValid;
  }

  // Step 2 validation
  bool _validateStep2() {
    setState(() => _nationalIdError = null);

    bool isValid = true;

    if (_nationalIdController.text.isEmpty ||
        _nationalIdController.text.length != 14 ||
        !RegExp(r'^\d+$').hasMatch(_nationalIdController.text)) {
      setState(() => _nationalIdError = 'الرجاء إدخال رقم قومي صحيح');
      isValid = false;
    }

    if (_firstNameController.text.isEmpty ||
        _familyNameController.text.isEmpty) {
      isValid = false;
    }

    return isValid;
  }

  bool get _isStep2Valid {
    return _firstNameController.text.isNotEmpty &&
        _familyNameController.text.isNotEmpty &&
        _nationalIdController.text.isNotEmpty &&
        _acceptedTerms;
  }

  bool get _isStep1Valid {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        emailRegex.hasMatch(_emailController.text) &&
        _phoneController.text.isNotEmpty &&
        _phoneController.text.length >= 10;
  }

  // Password validation
  void _checkPasswordRequirements(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _hasSpecialChar = RegExp(
        r'''[!@#$%^&*()_+\-=\[\]{};:'",.<>/?\\|`~]''',
      ).hasMatch(password);
      _notSameAsUsername =
          password.toLowerCase() != _usernameController.text.toLowerCase();
    });
  }

  bool get _allPasswordRequirementsMet {
    return _hasMinLength &&
        _hasLetter &&
        _hasNumber &&
        _hasSpecialChar &&
        _notSameAsUsername;
  }

  void _onNextPressed() {
    switch (_currentStep) {
      case 0:
        if (_validateStep1()) _goToNextStep();
        break;
      case 1:
        if (_validateStep2()) _goToNextStep();
        break;
      case 2:
        if (_allPasswordRequirementsMet) {
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SignupAppBar(
        step: _stepText,
        nextStepText: _nextStepText,
        onBackPressed: _goToPreviousStep,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        onPageChanged: (index) {
          setState(() => _currentStep = index);
        },
        children: [
          SignupStep1Form(
            usernameController: _usernameController,
            emailController: _emailController,
            phoneController: _phoneController,
            usernameError: _usernameError,
            emailError: _emailError,
            phoneError: _phoneError,
            onUsernameChanged: (value) {
              setState(() {
                _usernameError = null;
                if (value.isEmpty && _usernameController.text.isEmpty) {
                  _usernameError = 'الرجاء إدخال اسم مستخدم صحيح';
                }
              });
            },
            onEmailChanged: (value) {
              setState(() {
                _emailError = null;
                if (value.isNotEmpty) {
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    _emailError = 'الرجاء إدخال عنوان بريد إلكتروني صحيح';
                  }
                }
              });
            },
            onPhoneChanged: (value) {
              setState(() {
                _phoneError = null;
                if (value.isNotEmpty && value.length < 10) {
                  _phoneError =
                      'الرجاء إدخال رقم هاتف صحيح (10 أرقام على الأقل)';
                }
              });
            },
            onNextPressed: _onNextPressed,
            isValid: _isStep1Valid,
          ),
          SignupStep2Form(
            firstNameController: _firstNameController,
            familyNameController: _familyNameController,
            nationalIdController: _nationalIdController,
            nationalIdError: _nationalIdError,
            acceptedTerms: _acceptedTerms,
            onTermsChanged: (value) {
              setState(() {
                _acceptedTerms = value ?? false;
              });
            },
            onFieldChanged: (_) {
              if (_nationalIdError != null) {
                setState(() => _nationalIdError = null);
              }
              setState(() {});
            },
            onNextPressed: _onNextPressed,
            onPreviousPressed: _goToPreviousStep,
            isValid: _isStep2Valid,
          ),
          SignupStep3Form(
            passwordController: _passwordController,
            obscurePassword: _obscurePassword,
            onToggleObscure: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            onPasswordChanged: _checkPasswordRequirements,
            hasMinLength: _hasMinLength,
            hasLetter: _hasLetter,
            hasNumber: _hasNumber,
            hasSpecialChar: _hasSpecialChar,
            notSameAsUsername: _notSameAsUsername,
            onNextPressed: _onNextPressed,
            onPreviousPressed: _goToPreviousStep,
            isValid: _allPasswordRequirementsMet,
          ),
        ],
      ),
    );
  }
}
