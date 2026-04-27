import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/api/api_client.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_list_item.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/generic_terms_screen.dart';
import 'package:traffic/core/widgets/generic_document_upload_screen.dart';
import 'package:traffic/features/vehicle_license/data/repositories/vehicle_license_repository.dart';
import 'package:traffic/features/vehicle_license/presentation/cubits/vehicle_license_cubit.dart';
import 'package:traffic/features/vehicle_license/presentation/cubits/vehicle_license_state.dart';
import 'package:traffic/features/vehicle_license/presentation/screens/vehicle_insurance_screen.dart';
import 'package:traffic/features/profile/data/repositories/profile_repository.dart';

import 'package:traffic/features/vehicle_license/replacement_license/presentation/screens/vehicle_lost_license_selection_screen.dart';
import 'package:traffic/features/vehicle_license/renewal_license/presentation/screens/renewal_vehicle_selection_screen.dart';
import 'package:traffic/features/vehicle_license/violations_inquiry/presentation/screens/select_vehicle_violation_screen.dart';

class VehicleLicenseScreen extends StatefulWidget {
  const VehicleLicenseScreen({super.key});

  @override
  State<VehicleLicenseScreen> createState() => _VehicleLicenseScreenState();
}

class _VehicleLicenseScreenState extends State<VehicleLicenseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<TermsSection> _termsData = [
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
  ];

  void _onIssuanceTapped() {
    final cubit = VehicleLicenseCubit(
      VehicleLicenseRepository(ApiClient()),
      ProfileRepository(ApiClient()),
    );

    // Kick off API load immediately so data is ready by the time the user
    // finishes reading the terms screen.
    cubit.fetchInitData();

    final documents = [
      DocumentItemModel(title: 'عقد البيع / اثبات ملكية', isRequired: true),
      DocumentItemModel(title: 'شهادة بيانات المركبة', isRequired: true),
      DocumentItemModel(
        title: 'صورة البطاقة الشخصية (وجه + ظهر)',
        isRequired: true,
      ),
      DocumentItemModel(title: 'الافراج الجمركي', isRequired: false),
      DocumentItemModel(title: 'شهادة التأمين السارية', isRequired: false),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: GenericTermsScreen(
            appBarTitle: 'اصدار رخصة مركبة',
            subtitle: 'يرجى قراءة الشروط بعناية قبل متابعة الإصدار.',
            disclaimer:
                'قبل المتابعة، يرجى التأكد أن المركبة تستوفي جميع الشروط المطلوبة. في حال عدم استيفاء أي شرط، لن تتمكن من إتمام الإصدار إلكترونيًا.',
            termsData: _termsData,
            onNextPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    // BlocBuilder waits for VehicleLicenseInitDataSuccess so
                    // vehicle type / brand / model dropdowns are populated from
                    // the API (GET /VehicleTypes) rather than hardcoded lists.
                    child: BlocBuilder<VehicleLicenseCubit, VehicleLicenseState>(
                      builder: (ctx, state) {
                        // ── Derive dropdown options from API response ────────
                        List<String> typeOptions = [];
                        List<String> brandOptions = [];
                        List<String> modelOptions = [];

                        if (state is VehicleLicenseInitDataSuccess) {
                          final types = state.vehicleTypes;
                          typeOptions =
                              types.map((t) => t.displayName).toList();
                          // Flatten all brands and models across all types so
                          // the existing GenericDocumentUploadScreen still works.
                          final allBrands = types
                              .expand((t) => t.brands)
                              .toList();
                          brandOptions =
                              allBrands.map((b) => b.displayName).toList();
                          modelOptions = allBrands
                              .expand((b) => b.models)
                              .map((m) => m.displayName)
                              .toList();
                        } else if (state is VehicleLicenseLoading) {
                          return const Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is VehicleLicenseFailure) {
                          // On failure, retry once and fall through to
                          // show the screen with a minimal fallback.
                          typeOptions = ['ملاكي', 'نقل', 'أجرة', 'دراجة نارية'];
                          brandOptions = ['تويوتا', 'هيونداي', 'كيا', 'نيسان'];
                          modelOptions = ['2023', '2024', '2025', '2026'];
                        }

                        return GenericDocumentUploadScreen(
                          appBarTitle: 'اصدار رخصة مركبة',
                          subtitle:
                              'يرجى رفع المستندات التالية لإتمام إجراءات إصدار رخصة المركبة. يجب أن تكون الصور واضحة ومقروءة.',
                          dropdowns: [
                            DropdownConfig(
                              title: 'نوع المركبة',
                              hint: 'اختر نوع المركبة',
                              options: typeOptions,
                            ),
                            DropdownConfig(
                              title: 'الماركة',
                              hint: 'اختر الماركة',
                              options: brandOptions,
                            ),
                            DropdownConfig(
                              title: 'الموديل',
                              hint: 'اختر الموديل',
                              options: modelOptions,
                            ),
                          ],
                          documents: documents,
                          onNextPressed: (selectedDropdowns) {
                            Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: cubit,
                                  child: VehicleInsuranceScreen(
                                    documents: documents,
                                    selectedDropdowns: selectedDropdowns,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
                    icon: 'assets/license_s.svg',
                    onTap: _onIssuanceTapped,
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const VehicleLostLicenseSelectionScreen(),
                      ),
                    ),
                    title: 'اصدار بدل فاقد / تالف رخصة مركبة',
                    icon: 'assets/file_s.svg',
                  ),
                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'تجديد رخصة مركبة',
                    icon: 'assets/loding.svg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GenericTermsScreen(
                          appBarTitle: 'تجديد رخصة مركبة',
                          subtitle:
                              'يرجى قراءة الشروط بعناية قبل متابعة التجديد.',
                          disclaimer:
                              'قبل المتابعة، يرجى التأكد أن المركبة تستوفي جميع الشروط المطلوبة. في حال عدم استيفاء أي شرط، لن تتمكن من إتمام التجديد إلكترونيًا.',
                          termsData: _termsData,
                          onNextPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const RenewalVehicleSelectionScreen(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                  ServiceListItem(
                    title: 'استعلام عن مخالفات المركبة و سدادها',
                    icon: 'assets/search.svg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SelectVehicleViolationScreen(),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                  const ServiceListItem(
                    title: 'سداد مخالفات المركبة',
                    icon: 'assets/cart_payment.svg',
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
