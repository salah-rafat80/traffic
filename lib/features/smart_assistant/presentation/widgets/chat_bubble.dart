import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// A single chat message bubble.
///
/// [isUser] = true  → green bubble on the left  (user message)
/// [isUser] = false → gray  bubble on the right (bot message)
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 290.w),
        margin: EdgeInsets.only(
          bottom: 12.h,
          left: isUser ? 16.w : 50.w,
          right: isUser ? 50.w : 16.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF2E7D32) : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(17.r),
            topRight: Radius.circular(17.r),
            bottomLeft: isUser ? Radius.zero : Radius.circular(17.r),
            bottomRight: isUser ? Radius.circular(17.r) : Radius.zero,
          ),
        ),
        child: Text(
          text,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isUser ? Colors.white : const Color(0xFF222222),
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
