import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Sticky bottom input bar for the chat screen.
///
/// The send button sits **inside** the TextField as a prefixIcon (left in RTL).
/// Icon colour: gray when field is empty → green when there is text.
class ChatInputField extends StatefulWidget {
  final ValueChanged<String> onSend;

  const ChatInputField({super.key, required this.onSend});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SafeArea(
        top: false,
        child: Container(
          constraints: BoxConstraints(minHeight: 42.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              final hasText = value.text.trim().isNotEmpty;
              return TextField(
                controller: _controller,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                minLines: 1,
                maxLines: 5, // Grow up to 5 lines then scroll
                keyboardType: TextInputType.multiline,
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF222222),
                ),
                decoration: InputDecoration(
                  hintText: 'اكتب سؤالك هنا......',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9CA3AF),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  prefixIcon: GestureDetector(
                    onTap: _handleSend,
                    child: SizedBox(
                      width: 35.w,
                      height: 35.w,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SvgPicture.asset(
                            hasText
                                ? 'assets/send_but_green.svg'
                                : 'assets/send_but.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                onSubmitted: (_) => _handleSend(),
              );
            },
          ),
        ),
      ),
    );
  }
}
