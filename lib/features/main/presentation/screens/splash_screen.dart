import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/features/auth/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:traffic/features/auth/data/repositories/auth_repository.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/features/home/presentation/screens/main_navigation_screen.dart';
import 'package:traffic/features/examiner_dashboard/presentation/screens/daily_tests_screen.dart';
import 'package:traffic/injection_container.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      // Wait for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      // Check authentication status
      final authRepository = getIt<AuthRepository>();
      final isAuthenticated = await authRepository.hasToken();

      if (!mounted) return;

      if (isAuthenticated) {
        final roles = await authRepository.getRoles();
        final isStaff =
            roles.any((r) => ['INSPECTOR', 'DOCTOR', 'EXAMINATOR'].contains(r));

        if (isStaff) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DailyTestsScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const MainNavigationScreen()),
          );
        }
      } else {
        // Navigate to onboarding screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } catch (e, stack) {
      debugPrint('🚨 CRITICAL ERROR during SplashScreen init: $e');
      debugPrint('Stack trace: $stack');
      
      if (!mounted) return;
      // If error occurs, fallback to onboarding to avoid stuck splash
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive logo size
    final logoSize = 250.r;

    return Scaffold(
      backgroundColor: const Color(0xFF27AE60),
      body: Center(
        child: Image.asset(
          'assets/لوجو_2-removebg-preview (2).png',
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
