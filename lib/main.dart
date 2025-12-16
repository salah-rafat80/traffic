import 'package:flutter/material.dart';
import 'package:traffic/onboarding_screen.dart';
import 'package:traffic/design_system/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic App',
      theme: AppTheme.light(arabic: true),
      home: const OnboardingScreen(),
    );
  }
}
