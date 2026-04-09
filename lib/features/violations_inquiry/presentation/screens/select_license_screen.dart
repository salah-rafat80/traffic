import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/driving_license/data/models/driving_license_model.dart';
import 'package:traffic/features/driving_license/data/repositories/driving_license_repository.dart';
import 'package:traffic/features/violations_inquiry/presentation/screens/violations_list_screen.dart';
import 'package:traffic/features/violations_inquiry/presentation/widgets/license_details_card.dart';

class SelectLicenseScreen extends StatefulWidget {
  const SelectLicenseScreen({super.key});

  @override
  State<SelectLicenseScreen> createState() => _SelectLicenseScreenState();
}

class _SelectLicenseScreenState extends State<SelectLicenseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DrivingLicenseModel> _licenses = [];
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLicenses();
  }

  Future<void> _loadLicenses() async {
    setState(() => _isLoading = true);
    try {
      final repository = DrivingLicenseRepository(ApiClient());
      final cachedLicenses = await repository.getLocalLicenses();
      setState(() {
        _licenses = cachedLicenses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'استعلام عن مخالفات رخصة القيادة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          SizedBox(height: 5.h,),

          // ── Content ──
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 16.h),

                  // ── Section title ──
                  Center(
                    child: Text(
                      'تفاصيل رخصة القيادة',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ── License cards ──
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_licenses.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'لا يوجد رخص مسجلة حالياً',
                          style: TextStyle(fontFamily: 'Tajawal'),
                        ),
                      ),
                    )
                  else
                    ...List.generate(_licenses.length, (index) {
                      return LicenseDetailsCard(
                        license: _licenses[index],
                        isSelected: _selectedIndex == index,
                        onTap: () => setState(() => _selectedIndex = index),
                      );
                    }),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),

          // ── Next button ──
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
            child: PrimaryButton(
              label: 'التالي',
              onPressed: _isLoading || _licenses.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViolationsListScreen(
                            license: _licenses[_selectedIndex],
                          ),
                        ),
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }
}
