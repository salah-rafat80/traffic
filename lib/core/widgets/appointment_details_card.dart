import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card that displays the confirmed appointment's date, time, and
/// booking reference number after a booking has been made.
///
/// Matches the green-bordered card design in Iphone13Mini183.
///
/// **Usage:**
/// ```dart
/// AppointmentDetailsCard(
///   date: '25 اكتوبر 2025',
///   time: '10:30 صباحا',
///   bookingNumber: '10',
/// )
/// ```
class AppointmentDetailsCard extends StatelessWidget {
  /// Human-readable date string (e.g. "25 اكتوبر 2025").
  final String date;

  /// Human-readable time string (e.g. "10:30 صباحا").
  final String time;

  /// Booking reference number as a string.
  final String bookingNumber;

  const AppointmentDetailsCard({
    super.key,
    required this.date,
    required this.time,
    required this.bookingNumber,
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
            'موعد الكشف الطبي',
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
