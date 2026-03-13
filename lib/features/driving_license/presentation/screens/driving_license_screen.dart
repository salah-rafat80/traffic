import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/generic_booking_screen.dart';
import 'package:traffic/core/widgets/service_list_item.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/generic_terms_screen.dart';
import 'package:traffic/features/driving_license/presentation/screens/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:traffic/features/driving_license/presentation/screens/theory_test/theory_test_booking_screen.dart';
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
                        builder: (_) => GenericTermsScreen(
                          appBarTitle: 'تجديد رخصة القيادة',
                          subtitle:
                              'يرجى قراءة الشروط بعناية قبل متابعة التجديد.',
                          disclaimer:
                              'قبل المتابعة، يرجى التأكد أن المركبة تستوفي جميع الشروط المطلوبة. في حال عدم استيفاء أي شرط، لن تتمكن من إتمام التجديد إلكترونيًا.',
                          termsData: const [
                            TermsSection(
                              title: 'الأهلية العامة',
                              content:
                                  'الخدمة متاحة فقط للمركبات المسجلة باسم صاحب الحساب.\nيجب أن تكون المركبة من الفئات المسموح لها بالتجديد إلكترونيًا.',
                              iconData: Icons.person_outline_rounded,
                            ),
                            TermsSection(
                              title: 'المخالفات والرسوم',
                              content:
                                  'يجب سداد جميع المخالفات المرورية قبل إتمام عملية التجديد.\nفي حال وجود مخالفات، سيتم توجيهك لخطوة السداد قبل المتابعة.',
                              iconData: Icons.receipt_long_outlined,
                            ),
                            TermsSection(
                              title: 'التأمين والفحص الفني',
                              content:
                                  'يشترط وجود تأمين إلزامي ساري المفعول.\nقد يتطلب الفحص الفني حسب سنة الصنع أو حالة المركبة.',
                              iconData: Icons.verified_user_outlined,
                            ),
                            TermsSection(
                              title: 'حالات تمنع التجديد الإلكتروني',
                              content:
                                  'لا يمكن التجديد إلكترونيًا إذا كانت الرخصة مسحوبة أو موقوفة.\nلا يمكن التجديد في حالة وجود أمر قضائي أو حجز على المركبة.\nفي حالة عدم تطابق بيانات المالك، يلزم التوجه إلى وحدة المرور.',
                              iconData: Icons.receipt_outlined,
                            ),
                            TermsSection(
                              title: 'الاستلام والتوصيل',
                              content:
                                  'يمكنك اختيار استلام الرخصة من وحدة المرور أو طلب توصيلها للعنوان.\nرسوم التوصيل تُحتسب حسب المحافظة والعنوان.',
                              iconData: Icons.local_shipping_outlined,
                            ),
                          ],
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TheoryTestBookingScreen(
                                  appBarTitle: 'تجديد رخصة القيادة',
                                ),
                              ),
                            );
                          },
                        ),
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
