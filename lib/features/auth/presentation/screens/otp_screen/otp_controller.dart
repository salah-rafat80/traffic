import 'package:flutter/material.dart';

/// Controller for OTP screen logic.
/// Uses ChangeNotifier for state management without external packages.
class OtpController extends ChangeNotifier {
  OtpController({
    required this.email,
    this.onComplete,
  }) {
    _initControllers();
    startTimer();
  }

  final String email;
  final void Function(String)? onComplete;

  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];
  String? _currentOtp;

  bool _showError = false;
  bool get showError => _showError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setError(bool value, [String? message]) {
    _showError = value;
    _errorMessage = value ? message : null;
    notifyListeners();
  }

  int _timerSeconds = 300; // 5:00 minutes
  int get timerSeconds => _timerSeconds;

  bool _isTimerRunning = true;
  bool get isTimerRunning => _isTimerRunning;

  bool _isComplete = false;
  bool get isComplete => _isComplete;

  void _initControllers() {
    for (int i = 0; i < 6; i++) {
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

    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    final otp = controllers.map((c) => c.text).join();
    if (otp.length == 6 && _currentOtp != otp) {
      _currentOtp = otp;
      _isComplete = true; // Signal UI that OTP is ready
      notifyListeners();
      onComplete?.call(otp); // Fire callback exactly once here
    } else if (otp.length < 6) {
      _isComplete = false;
      _currentOtp = null;
    }
  }

  void handleBackspace(int index) {
    if (controllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  String get otpCode => controllers.map((c) => c.text).join();

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
