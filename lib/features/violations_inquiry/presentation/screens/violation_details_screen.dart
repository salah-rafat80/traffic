import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/app_drawer.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';
import 'package:traffic/features/violations_inquiry/data/models/violation_model.dart';

class ViolationDetailsScreen extends StatefulWidget {
  final ViolationModel violation;

  const ViolationDetailsScreen({super.key, required this.violation});

  @override
  State<ViolationDetailsScreen> createState() => _ViolationDetailsScreenState();
}

class _ViolationDetailsScreenState extends State<ViolationDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final v = widget.violation;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),

                  // ── Section title ──
                  Text(
                    'تفاصيل المخالفة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Status tag ──
                  _StatusTag(isPaid: v.isPaid),
                  SizedBox(height: 20.h),

                  // ── Violation title ──
                  Text(
                    v.title,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ── Violation image ──
                  _ViolationImage(isPaid: v.isPaid),
                  SizedBox(height: 28.h),

                  // ── Details card ──
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: const Color(0xFFE8E8E8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(

                      children: [
                        _DetailRow(
                          label: 'التاريخ والوقت',
                          value: '${v.time}, ${v.date}',
                        ),
                        _divider(),
                        _DetailRow(label: 'الموقع', value: v.location),
                        _divider(),
                        _DetailRow(
                          label: 'المادة القانون',
                          value: '${v.articleNumber} / ${v.articleText}',
                        ),
                        _divider(),
                        _DetailRow(
                          label: 'قيمة المخالفة',
                          value: '${v.amount.toInt()} جنيه مصري',
                        ),
                        _divider(),
                        _DetailRow(
                          label: 'رقم المخالفة',
                          value: v.violationNumber,
                        ),
                        if (v.isPaid && v.paymentDate != null) ...[
                          _divider(),
                          _DetailRow(
                            label: 'تاريخ وقت السداد',
                            value: v.paymentDate!,
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // ── Bottom button (only for unpaid) ──
          if (!v.isPaid)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'سداد المخالفة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: const Divider(color: Color(0xFFEEEEEE), height: 1),
  );
}

// ── Status tag ───────────────────────────────────────────────────────────────

class _StatusTag extends StatelessWidget {
  final bool isPaid;
  const _StatusTag({required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isPaid
            ? const Color(0xFF2E7D32).withValues(alpha: 0.1)
            : const Color(0xFFD32F2F).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isPaid ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F),
          width: 1,
        ),
      ),
      child: Text(
        isPaid ? 'مدفوعة' : 'غير مدفوعة',
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isPaid ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F),
        ),
      ),
    );
  }
}

// ── Violation image with no-entry overlay for unpaid ─────────────────────────

class _ViolationImage extends StatelessWidget {
  final bool isPaid;
  const _ViolationImage({required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.w,
      height: 140.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Car icon ──
          Icon(
            Icons.directions_car,
            size: 80.w,
            color: const Color(0xFF666666),
          ),

          // ── No-entry overlay for unpaid ──
          if (!isPaid)
            Container(
              width: 160.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD32F2F), width: 6),
              ),
              child: Center(
                child: Container(
                  width: 100.w,
                  height: 6,
                  color: const Color(0xFFD32F2F),
                  transform: Matrix4.rotationZ(-0.7),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Detail row ───────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.w,
          child: Text(
            label,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF555555),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }
}
