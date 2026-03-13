import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_list_item.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/generic_terms_screen.dart';
import 'package:traffic/core/widgets/generic_document_upload_screen.dart';
import 'package:traffic/features/vehicle_license/presentation/screens/vehicle_insurance_screen.dart';

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
          ),
          SizedBox(height: 5.h),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  ServiceListItem(
                    title: 'اصدار رخصة مركبة لأول مرة',
                    icon: "assets/license_s.svg",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GenericTermsScreen(
                          appBarTitle: 'اصدار رخصة مركبة',
                          subtitle:
                              'يرجى قراءة الشروط بعناية قبل متابعة التجديد.',
                          disclaimer:
                              'قبل المتابعة، يرجى التأكد أن المركبة تستوفي جميع الشروط المطلوبة. في حال عدم استيفاء أي شرط، لن تتمكن من إتمام التجديد إلكترونيًا.',
                          termsData: const [
                            TermsSection(
                              title: 'الأهلية العامة',
                              content:
                                  'الخدمة متاحة فقط للمركبات المسجلة باسم صاحب الحساب.\nيجب أن تكون المركبة من الفئات المسموح لها بالتجديد إلكترونيًا.', // Dummy content
                              iconData: Icons.person_outline_rounded,
                            ),
                            TermsSection(
                              title: 'المخالفات والرسوم',
                              content:
                                  'يجب سداد جميع المخالفات المرورية قبل إتمام عملية التجديد.\nفي حال وجود مخالفات، سيتم توجيهك لخطوة السداد قبل المتابعة.', // Dummy content
                              iconData: Icons.receipt_long_outlined,
                            ),
                            TermsSection(
                              title: 'التأمين والفحص الفني',
                              content:
                                  'يشترط وجود تأمين إلزامي ساري المفعول.\nقد يتطلب الفحص الفني حسب سنة الصنع أو حالة المركبة.', // Dummy content
                              iconData: Icons.verified_user_outlined,
                            ),
                            TermsSection(
                              title: 'حالات تمنع التجديد الإلكتروني',
                              content:
                                  'لا يمكن التجديد إلكترونيًا إذا كانت الرخصة مسحوبة أو موقوفة.\nلا يمكن التجديد في حالة وجود أمر قضائي أو حجز على المركبة.\nفي حالة عدم تطابق بيانات المالك، يلزم التوجه إلى وحدة المرور.', // Dummy content
                              iconData: Icons.receipt_outlined,
                            ),
                            TermsSection(
                              title: 'الاستلام والتوصيل',
                              content:
                                  'يمكنك اختيار استلام الرخصة من وحدة المرور أو طلب توصيلها للعنوان.\nرسوم التوصيل تُحتسب حسب المحافظة والعنوان.', // Dummy content
                              iconData: Icons.local_shipping_outlined,
                            ),
                          ],
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GenericDocumentUploadScreen(
                                  appBarTitle: 'اصدار رخصة مركبة',
                                  subtitle:
                                      'يرجى رفع المستندات التالية لإتمام إجراءات إصدار رخصة المركبة. يجب أن تكون الصور واضحة ومقروءة.',
                                  dropdowns: const [
                                    DropdownConfig(
                                      title: 'نوع المركبة',
                                      hint: 'اختر نوع المركبة',
                                      options: [
                                        'ملاكي',
                                        'نقل',
                                        'أجرة',
                                        'دراجة نارية',
                                      ], // Dummy options
                                    ),
                                    DropdownConfig(
                                      title: 'الموديل',
                                      hint: 'اختر نوع الموديل',
                                      options: [
                                        '2024',
                                        '2023',
                                        '2022',
                                        '2021',
                                      ], // Dummy options
                                    ),
                                  ],
                                  documents: [
                                    DocumentItemModel(
                                      title: 'عقد البيع / اثبات ملكية',
                                      isRequired: true,
                                    ),
                                    DocumentItemModel(
                                      title: 'شهادة بيانات المركبة',
                                      isRequired: true,
                                    ),
                                    DocumentItemModel(
                                      title: 'صورة البطاقة الشخصية (وجه + ظهر)',
                                      isRequired: true,
                                    ),
                                    DocumentItemModel(
                                      title: 'الافراج الجمركي',
                                      isRequired: false,
                                    ),
                                    DocumentItemModel(
                                      title: 'شهادة التأمين السارية',
                                      isRequired: false,
                                    ),
                                  ],
                                  onNextPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const VehicleInsuranceScreen(),
                                      ),
                                    );
                                  },
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
