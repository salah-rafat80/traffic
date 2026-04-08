// path: lib/features/home/presentation/screens/main_navigation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/features/home/presentation/screens/home_screen.dart';
import 'package:traffic/features/profile/presentation/profile_screen.dart';
import 'package:traffic/features/orders/presentation/my_orders_screen.dart';
import 'package:traffic/features/orders/presentation/cubits/my_orders_cubit.dart';
import 'package:traffic/features/orders/data/repositories/service_requests_repository.dart';
import 'package:traffic/features/settings/presentation/screens/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({super.key, this.initialIndex = 3});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;
  late MyOrdersCubit _myOrdersCubit;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _myOrdersCubit = MyOrdersCubit(ServiceRequestsRepository(ApiClient()));
    
    _screens = [
      const ProfileScreen(),
      const SettingsScreen(),
      BlocProvider.value(
        value: _myOrdersCubit,
        child: const MyOrdersScreen(),
      ),
      const HomeScreen(),
    ];

    if (_currentIndex == 2) {
      _myOrdersCubit.fetchMyOrders();
    }
  }

  @override
  void dispose() {
    _myOrdersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
          if (i == 2) {
            _myOrdersCubit.fetchMyOrders();
          }
        },
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF27AE60),
          unselectedItemColor: const Color(0xFF9CA3AF),
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/profile.svg"),
              activeIcon: SvgPicture.asset("assets/profile_G.svg"),
              label: 'حسابي',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/settings.svg"),
              activeIcon: SvgPicture.asset("assets/settings_G.svg"),
              label: 'الاعدادات',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/order.svg"),
              activeIcon: SvgPicture.asset("assets/order_G.svg"),
              label: 'طلباتي',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/home.svg"),
              activeIcon: SvgPicture.asset("assets/home_G.svg"),
              label: 'الصفحة الرئيسية',
            ),
          ],
        ),
      ),
    );
  }
}
