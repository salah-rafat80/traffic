import 'package:flutter/material.dart';

class SignupAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String step; // "1 من 3", "2 من 3", "3 من 3"
  final String? nextStepText; // "التالي : البيانات الشخصية"
  final VoidCallback? onBackPressed;

  const SignupAppBar({
    super.key,
    required this.step,
    this.nextStepText,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            // Row 1: Logo centered on right
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 35,
                child: Image.asset('assets/logo.png', fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 16),
            // Row 2: Title with arrow + Progress bars
            Row(
              children: [
                // Progress bars (3 segments) - LEFT side
                Expanded(child: Row(children: _buildProgressBars())),
                const SizedBox(width: 16),
                // Title with arrow - RIGHT side
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onBackPressed ?? () => Navigator.pop(context),
                      child: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Row 3: Step number + Next step text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Next step text - LEFT side
                if (nextStepText != null)
                  Text(
                    nextStepText!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF999999),
                      fontFamily: 'Tajawal',
                    ),
                  )
                else
                  const SizedBox(),
                // Step number - RIGHT side
                Text(
                  step,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF666666),
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProgressBars() {
    final int currentStep = _getCurrentStep();
    return List.generate(3, (index) {
      // Reverse index for RTL (3, 2, 1 instead of 1, 2, 3)
      final int rtlIndex = 2 - index;
      final bool isActive = rtlIndex < currentStep;
      return Expanded(
        child: Container(
          height: 4,
          margin: EdgeInsets.only(left: index < 2 ? 4 : 0),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF27AE60) : const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    });
  }

  int _getCurrentStep() {
    if (step.contains('1')) return 1;
    if (step.contains('2')) return 2;
    if (step.contains('3')) return 3;
    return 1;
  }
}
