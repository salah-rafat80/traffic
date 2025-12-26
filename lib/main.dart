import 'package:flutter/material.dart';
import 'package:traffic/core/utils/app_theme.dart';
import 'package:traffic/features/main/presentation/screens/splash_screen.dart';

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
      home: const SplashScreen(),
    );
  }
}
