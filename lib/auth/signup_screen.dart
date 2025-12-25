import 'package:flutter/material.dart';
import '../widgets/signup_app_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_requirement_item.dart';

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
        children: [_buildStep1(), _buildStep2(), _buildStep3()],
      ),
    );
  }

  // Step 1: Contact Information
  Widget _buildStep1() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // const SizedBox(height: 8),
            const Text(
              'معلومات التواصل',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Tajawal',
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 5),
            Row(
              children: [
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
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
                      fontSize: 14,
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
            SizedBox(height: size.height * 0.12),
            // Next button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBDBDBD),
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
          ],
        ),
      ),
    );
  }

  // Step 2: Personal Information
  Widget _buildStep2() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            const Text(
              'البيانات الشخصية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Tajawal',
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 5),
            CustomTextField(
              controller: _firstNameController,
              hintText: 'أميرة',
              textAlign: TextAlign.right,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 5),
            CustomTextField(
              controller: _familyNameController,
              hintText: 'بدر',
              textAlign: TextAlign.right,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 5),
            CustomTextField(
              controller: _nationalIdController,
              hintText: '12345678900-',
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
            const SizedBox(height: 20),
            // Terms checkbox
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'أوافق على جميع الشروط والأحكام',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
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
                // Next button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isStep2Valid ? _onNextPressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isStep2Valid
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
                // Previous button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: _goToPreviousStep,
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
          ],
        ),
      ),
    );
  }

  // Step 3: Password Creation
  Widget _buildStep3() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            const Text(
              'أنشئ كلمة المرور الخاصة بك',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Tajawal',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'أنشئ كلمة المرور',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'Tajawal',
              ),
            ),
            const SizedBox(height: 5),
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
            const SizedBox(height: 20),
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
                  'تحتوي على رمز خاص واحد على الأقل\n! @ # \$ % ^ & * ( ) _ + - = [ ] { } ; : \' " \\ | , . < > / ?',
              isMet: _hasSpecialChar,
            ),
            PasswordRequirementItem(
              text: 'يجب ألا تكون كلمة المرور مطابقة عن اسم المستخدم',
              isMet: _notSameAsUsername,
            ),
            SizedBox(height: size.height * 0.08),
            // Buttons
            Row(
              children: [
                // Next button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _allPasswordRequirementsMet
                          ? _onNextPressed
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _allPasswordRequirementsMet
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
                // Previous button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: _goToPreviousStep,
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
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
