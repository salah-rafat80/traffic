import 'package:flutter/material.dart';

/// Controller for OTP screen logic.
/// Uses ChangeNotifier for state management without external packages.
class OtpController extends ChangeNotifier {
  OtpController({required this.email}) {
    _initControllers();
    startTimer();
  }

  final String email;

  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];

  bool _showError = false;
  bool get showError => _showError;

  int _timerSeconds = 300; // 5:00 minutes
  int get timerSeconds => _timerSeconds;

  bool _isTimerRunning = true;
  bool get isTimerRunning => _isTimerRunning;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  void _initControllers() {
    for (int i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  String get formattedTimer {
    final minutes = (_timerSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timerSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get maskedEmail {
    if (email.length <= 7) return email;
    final visible = email.substring(0, 7);
    return '$visible*******';
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timerSeconds > 0 && _isTimerRunning) {
        _timerSeconds--;
        notifyListeners();
        startTimer();
      }
    });
  }

  void onOtpChanged(int index, String value) {
    if (_showError) {
      _showError = false;
      notifyListeners();
    }

    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    final otp = controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      verifyOtp(otp);
    }
  }

  void handleBackspace(int index) {
    if (controllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void verifyOtp(String otp) {
    // Demo: "1234" is correct, anything else shows error
    if (otp == '1234') {
      _isSuccess = true;
      notifyListeners();
    } else {
      _showError = true;
      notifyListeners();
    }
  }

  void resendOtp() {
    _timerSeconds = 300;
    _isTimerRunning = true;
    _showError = false;
    for (var controller in controllers) {
      controller.clear();
    }
    notifyListeners();
    focusNodes[0].requestFocus();
    startTimer();
  }

  bool get canResend => _timerSeconds == 0;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
