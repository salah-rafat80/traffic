import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_list_item.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/driving_license/presentation/screens/terms_and_conditions/renewal_terms_screen.dart';
import 'package:traffic/features/driving_license/presentation/screens/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/select_license_screen.dart';

import '../../../lost_license/presentation/screens/lost_license_selection_screen.dart';

class DrivingLicenseScreen extends StatefulWidget {
  const DrivingLicenseScreen({super.key});

  @override
  State<DrivingLicenseScreen> createState() => _DrivingLicenseScreenState();
}

class _DrivingLicenseScreenState extends State<DrivingLicenseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'رخصة القيادة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  ServiceListItem(
                    title: 'اصدار رخصة قيادة لأول مرة',
                    icon: 'assets/license_s.svg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TermsAndConditionsScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'تجديد رخصة القيادة',
                    icon: 'assets/loding.svg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RenewalTermsScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'اصدار بدل فاقد / تالف رخصة',
                    icon: "assets/file_s.svg",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LostLicenseSelectionScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'استعلام عن مخالفات رخصة القيادة',
                    icon: "assets/search.svg",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SelectLicenseScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'سداد مخالفات رخصة القيادة',
                    icon: "assets/cart_payment.svg",
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
