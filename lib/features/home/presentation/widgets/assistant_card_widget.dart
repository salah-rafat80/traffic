// path: lib/features/home/presentation/widgets/assistant_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/home/presentation/widgets/service_card.dart';
import 'package:traffic/features/smart_assistant/presentation/screens/smart_assistant_screen.dart';

class AssistantCardWidget extends StatelessWidget {
  const AssistantCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ServiceCard(
        title: 'المساعد الذكي',
        icon: "assets/si_ai.svg",
        isAssistant: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SmartAssistantScreen()),
        ),
      ),
    );
  }
}
