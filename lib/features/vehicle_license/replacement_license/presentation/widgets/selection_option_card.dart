import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/widgets/radio_dot.dart';

/// A tappable option card used on selection screens.
class SelectionOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  static const Color _selectedBorder = Color(0xFF27AE60);
  static const Color _unselectedBorder = Color(0xFFDADADA);
  static const Color _cardBackground = Color(0xFFF8F9F9);
  static const Color _iconBackground = Color(0xFFEFEFEF);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: _cardBackground,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: isSelected ? 1.5.w : 1.w,
              color: isSelected ? _selectedBorder : _unselectedBorder,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 45.w,
                height: 45.w,
                decoration: ShapeDecoration(
                  color: _iconBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Center(child: icon),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF707070),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              RadioDot(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}
