import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card that displays the confirmed appointment's date, time, booking
/// reference number, and optional request number after a booking has been made.
///
/// Generic enough to be used in both the medical-check and theory-test flows.
///
/// **Usage:**
/// ```dart
/// AppointmentDetailsCard(
///   title: 'موعد الاختبار',          // optional – defaults to 'موعد الكشف الطبي'
///   date: '25 اكتوبر 2025',
///   time: '10:30 صباحا',
///   bookingNumber: '10',
///   requestNumber: '13456670',       // optional
/// )
/// ```
class AppointmentDetailsCard extends StatelessWidget {
  /// Card heading. Defaults to `'موعد الكشف الطبي'` for backward compatibility.
  final String? title;

  /// Human-readable date string (e.g. "25 اكتوبر 2025").
  final String date;

  /// Human-readable time string (e.g. "10:30 صباحا").
  final String time;

  /// Booking reference number as a string.
  final String bookingNumber;

  /// Optional request / order number shown as a fourth row.
  final String? requestNumber;

  const AppointmentDetailsCard({
    super.key,
    this.title,
    required this.date,
    required this.time,
    required this.bookingNumber,
    this.requestNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFF27AE60)),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Card title ─────────────────────────────────────────────────
          Text(
            title ?? 'موعد الكشف الطبي',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color(0xFF222222),
              fontSize: 15.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),

          // ── Date row ───────────────────────────────────────────────────
          _DetailRow(
            icon: Icons.calendar_today_outlined,
            text: 'التاريخ : $date',
          ),
          SizedBox(height: 6.h),

          // ── Time row ───────────────────────────────────────────────────
          _DetailRow(icon: Icons.access_time_outlined, text: 'الساعة : $time'),
          SizedBox(height: 6.h),

          // ── Booking number row ─────────────────────────────────────────
          _DetailRow(
            icon: Icons.format_list_bulleted_outlined,
            text: 'رقم الحجز : $bookingNumber',
          ),

          // ── Request number row (optional) ──────────────────────────────
          if (requestNumber != null) ...[
            SizedBox(height: 6.h),
            _DetailRow(
              icon: Icons.receipt_long_outlined,
              text: 'رقم الطلب : $requestNumber',
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper: icon + label row (RTL)
// ─────────────────────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(icon, size: 18.r, color: const Color(0xFF27AE60)),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color(0xFF444444),
              fontSize: 12.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
