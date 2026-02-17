import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffic/features/auth/presentation/screens/otp_screen/otp_styles.dart';

/// Individual OTP input box widget.
class OtpInputBox extends StatefulWidget {
  const OtpInputBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onChanged,
    required this.onBackspace,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  @override
  State<OtpInputBox> createState() => _OtpInputBoxState();
}

class _OtpInputBoxState extends State<OtpInputBox> {
  late String _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.controller.text;
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final newValue = widget.controller.text;
    // Detect backspace when text becomes empty from non-empty
    if (_previousValue.isNotEmpty && newValue.isEmpty) {
      widget.onBackspace();
    }
    _previousValue = newValue;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: OtpStyles.inputBoxWidth,
      height: OtpStyles.inputBoxHeight,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: OtpStyles.otpInputStyle,
        decoration: OtpStyles.otpInputDecoration(
          hasError: widget.hasError,
          hasValue: widget.controller.text.isNotEmpty,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: widget.onChanged,
      ),
    );
  }
}
