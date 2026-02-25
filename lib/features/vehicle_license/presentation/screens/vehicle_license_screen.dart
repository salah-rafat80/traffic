import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_list_item.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';

class VehicleLicenseScreen extends StatefulWidget {
  const VehicleLicenseScreen({super.key});

  @override
  State<VehicleLicenseScreen> createState() => _VehicleLicenseScreenState();
}

class _VehicleLicenseScreenState extends State<VehicleLicenseScreen> {
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
            title: 'رخصة المركبة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),          SizedBox(height: 5.h,),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  ServiceListItem(
                    title: 'اصدار رخصة مركبة لأول مرة',
                    icon: "assets/license_s.svg",
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'اصدار بدل فاقد / تالف رخصة مركبة',
                    icon: "assets/file_s.svg",
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'تجديد رخصة مركبة',
                    icon: "assets/loding.svg",
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'استعلام عن مخالفات المركبة',
                    icon: "assets/search.svg",
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'سداد مخالفات المركبة',
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
