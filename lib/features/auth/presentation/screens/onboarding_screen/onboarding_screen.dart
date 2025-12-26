import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:traffic/core/constants/spacing.dart';
import 'package:traffic/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:traffic/features/auth/presentation/screens/signup_screen/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/Chat bot-rafiki (1) 1.svg",
      "title": "مساعدك الشخصي لخدمات المرور",
    },
    {
      "image": "assets/Hello-rafiki (2) 1.svg",
      "title": "مرحباً بك في منصة مرورنا الذكية",
    },
    {
      "image": "assets/Payment Information-rafiki (4) 1.svg",
      "title": "استعلام ودفع المخالفات بسهولة",
    },
    {
      "image": "assets/Schedule-rafiki 2.svg",
      "title": "احجز (كشف طبي - اختبار قيادة)",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isLargeScreen = size.width > 900;

    // Responsive sizing
    final horizontalPadding = isLargeScreen
        ? 48.0
        : (isTablet ? 32.0 : Insets.x16);
    final logoHeight = isTablet ? 50.0 : 40.0;
    final maxContentWidth = isLargeScreen ? 600.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                ),
                child: Text(
                  'English',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(
                width: logoHeight * 2,
                height: logoHeight,
                child: Image.asset('assets/logo.png', fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallHeight = size.height < 600;

                return Column(
                  children: [
                    // Spacer at top
                    SizedBox(height: isSmallHeight ? Insets.x16 : Insets.x32),

                    // Image PageView
                    Expanded(
                      flex: isSmallHeight ? 4 : 5,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _onboardingData.length,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (context, index) {
                          return OnboardingPage(
                            imageData: _onboardingData[index],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: isSmallHeight ? Insets.x16 : Insets.x24),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? Insets.x24 : Insets.x16,
                      ),
                      child: Text(
                        _onboardingData[_currentPage]['title']!,
                        style: TextStyle(
                          fontSize: isLargeScreen ? 24 : (isTablet ? 22 : 20),
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: isSmallHeight ? Insets.x16 : Insets.x24),

                    // Page Indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _onboardingData.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: const Color(0xFFD1D5DB),
                        dotHeight: isTablet ? 8 : 6,
                        dotWidth: isTablet ? 8 : 6,
                        spacing: isTablet ? 6 : 5,
                        expansionFactor: isTablet ? 3 : 2.5,
                      ),
                    ),

                    SizedBox(height: isSmallHeight ? Insets.x24 : Insets.x40),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 20 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isSmallHeight ? Insets.x16 : Insets.x24),

                    // Login Row
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 0,
                            ),
                            minimumSize: const Size(0, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'تسجيل دخول',
                            style: TextStyle(
                              fontSize: isTablet ? 17 : 15,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Text(
                          'لديك حساب بالفعل ؟',
                          style: TextStyle(
                            fontSize: isTablet ? 17 : 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    // Help Button
                    SizedBox(height: isSmallHeight ? Insets.x16 : Insets.x24),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final Map<String, String>? imageData;

  const OnboardingPage({super.key, this.imageData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final imagePadding = isTablet ? Insets.x40 : Insets.x32;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: imagePadding),
        child: SvgPicture.asset(
          imageData!['image']!,
          fit: BoxFit.contain,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
