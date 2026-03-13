import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/features/vehicle_license/presentation/screens/vehicle_inspection_booking_screen.dart';
import '../widgets/insurance_company_card.dart';

class VehicleInsuranceScreen extends StatefulWidget {
  const VehicleInsuranceScreen({super.key});

  @override
  State<VehicleInsuranceScreen> createState() => _VehicleInsuranceScreenState();
}

class _VehicleInsuranceScreenState extends State<VehicleInsuranceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  int? _selectedCompanyIndex;

  // Dummy data for insurance companies
  final List<Map<String, String>> _companies = [
    {
      'companyName': 'الشركة المصرية للتأمين',
      'details': 'السعر 890 جنية مصري , مدة التأمين : سنة , التغطية الاساسية : تغطية شاملة',
      'logoAssetPath': 'assets/images/insurance_logo.png', // Dummy asset
    },
    {
      'companyName': 'الشركة المصرية للتأمين',
      'details': 'السعر 890 جنية مصري , مدة التأمين : سنة , التغطية الاساسية : تغطية شاملة',
      'logoAssetPath': 'assets/images/insurance_logo.png', // Dummy asset
    },
    {
      'companyName': 'الشركة المصرية للتأمين',
      'details': 'السعر 890 جنية مصري , مدة التأمين : سنة , التغطية الاساسية : تغطية شاملة',
      'logoAssetPath': 'assets/images/insurance_logo.png', // Dummy asset
    },
  ];

  void _onNextPressed() {
    if (_selectedCompanyIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يرجى اختيار شركة التأمين أولاً',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VehicleInspectionBookingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          ServiceScreenAppBar(
            title: 'اصدار رخصة مركبة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                SizedBox(height: 16.h),
                Text(
                  'التأمين علي المركبة',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: const Color(0xFF222222),
                    fontSize: 17.sp,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'اختيار شركة التأمين',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                
                // Companies List
                ...List.generate(_companies.length, (index) {
                  final company = _companies[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: InsuranceCompanyCard(
                      companyName: company['companyName']!,
                      details: company['details']!,
                      logoAssetPath: company['logoAssetPath']!,
                      isSelected: _selectedCompanyIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedCompanyIndex = index;
                        });
                      },
                    ),
                  );
                }),
                
                SizedBox(height: 24.h),
                PrimaryButton(
                  onPressed: _onNextPressed,
                  label: 'التالي',
                  height: 48.h,
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
