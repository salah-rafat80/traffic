import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/features/auth/presentation/screens/signup_screen/widgets/signup_step1_form/widgets/next_button_widget.dart';

import 'package:traffic/features/driving_license/presentation/screens/license_details/license_details_screen.dart';
import 'widgets/agreement_checkbox.dart';
import 'widgets/custom_expansion_tile.dart';

// ── Terms data model ──────────────────────────────────────────────────────────

/// Holds the data for a single Terms & Conditions section.
class _TermsSection {
  final String title;
  final String content;
  final IconData iconData;

  const _TermsSection({
    required this.title,
    required this.content,
    required this.iconData,
  });
}

// ── Static terms data ─────────────────────────────────────────────────────────

const List<_TermsSection> _termsSections = [
  _TermsSection(
    title: 'الأهلية العامة',
    content:
        'الخدمة متاحة فقط للمركبات المسجلة باسم صاحب الحساب.\n'
        'يجب أن تكون المركبة من الفئات المسموح لها بالتجديد إلكترونيًا.',
    iconData: Icons.person_outline_rounded,
  ),
  _TermsSection(
    title: 'المخالفات والرسوم',
    content:
        'يجب سداد جميع المخالفات المرورية قبل إتمام عملية التجديد.\n'
        'في حال وجود مخالفات، سيتم توجيهك لخطوة السداد قبل المتابعة.',
    iconData: Icons.receipt_long_outlined,
  ),
  _TermsSection(
    title: 'التأمين والفحص الفني',
    content:
        'يشترط وجود تأمين إلزامي ساري المفعول.\n'
        'قد يتطلب الفحص الفني حسب سنة الصنع أو حالة المركبة.',
    iconData: Icons.verified_user_outlined,
  ),
  _TermsSection(
    title: 'حالات تمنع التجديد الإلكتروني',
    content:
        'لا يمكن التجديد إلكترونيًا إذا كانت الرخصة مسحوبة أو موقوفة.\n'
        'لا يمكن التجديد في حالة وجود أمر قضائي أو حجز على المركبة.\n'
        'في حالة عدم تطابق بيانات المالك، يلزم التوجه إلى وحدة المرور.',
    iconData: Icons.receipt_outlined,
  ),
  _TermsSection(
    title: 'الاستلام والتوصيل',
    content:
        'يمكنك اختيار استلام الرخصة من وحدة المرور أو طلب توصيلها للعنوان.\n'
        'رسوم التوصيل تُحتسب حسب المحافظة والعنوان.',
    iconData: Icons.local_shipping_outlined,
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

/// **Terms & Conditions** screen for the **Licence Renewal** flow.
///
/// Displays five collapsible sections using [CustomExpansionTile]. The primary
/// action button ("التالي") is disabled until the user checks the agreement
/// checkbox.
///
/// State is kept local ([StatefulWidget]) until a Cubit is introduced.
class RenewalTermsScreen extends StatefulWidget {
  const RenewalTermsScreen({super.key});

  @override
  State<RenewalTermsScreen> createState() => _RenewalTermsScreenState();
}

class _RenewalTermsScreenState extends State<RenewalTermsScreen> {
  /// Whether the user has agreed to the terms.
  bool _isAgreed = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ── Handlers ──────────────────────────────────────────────────────────────

  void _onAgreementChanged(bool value) {
    setState(() => _isAgreed = value);
  }

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LicenseDetailsScreen()),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // ── App bar ──────────────────────────────────────────────────────
          ServiceScreenAppBar(
            title: 'تجديد رخصة القيادة',
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),

          // ── Scrollable body ──────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),

                  // ── Section header ────────────────────────────────────────
                  Text(
                    'الشروط والأحكام',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 17.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // ── Sub-title ─────────────────────────────────────────────
                  Text(
                    'يرجى قراءة الشروط بعناية قبل متابعة التجديد.',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 14.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // ── Disclaimer ────────────────────────────────────────────
                  Text(
                    'قبل المتابعة، يرجى التأكد أن المركبة تستوفي جميع الشروط المطلوبة. '
                    'في حال عدم استيفاء أي شرط، لن تتمكن من إتمام التجديد إلكترونيًا.',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 12.sp,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Expansion tiles container ──────────────────────────────
                  Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF8F9F9),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: const Color(0xFFDADADA),
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Column(children: _buildTileList()),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Agreement checkbox ─────────────────────────────────────
                  AgreementCheckbox(
                    isAgreed: _isAgreed,
                    onChanged: _onAgreementChanged,
                  ),

                  SizedBox(height: 16.h),

                  // ── Primary action button ──────────────────────────────────
                  NextButtonWidget(
                    onPressed: _onNextPressed,
                    isValid: _isAgreed,
                    height: 48.h,
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

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Builds the list of [CustomExpansionTile] widgets separated by dividers.
  List<Widget> _buildTileList() {
    final List<Widget> tiles = [];

    for (int i = 0; i < _termsSections.length; i++) {
      final section = _termsSections[i];

      tiles.add(
        CustomExpansionTile(
          title: section.title,
          content: section.content,
          icon: Icon(
            section.iconData,
            color: const Color(0xFF27AE60),
            size: 22.r,
          ),
        ),
      );

      // Add divider between tiles (not after the last one)
      if (i < _termsSections.length - 1) {
        tiles.add(
          Divider(
            height: 1.h,
            thickness: 1.h,
            color: const Color(0xFFDADADA),
            indent: 12.w,
            endIndent: 12.w,
          ),
        );
      }
    }

    return tiles;
  }
}
