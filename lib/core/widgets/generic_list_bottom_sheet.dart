import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A highly-reusable modal bottom sheet that displays a scrollable list of
/// [String] items and fires [onItemSelected] when the user taps one.
///
/// **Usage:**
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   shape: RoundedRectangleBorder(
///     borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
///   ),
///   builder: (_) => GenericListBottomSheet(
///     title: 'اختر محافظتك',
///     items: _governorates,
///     onItemSelected: (value) => setState(() => _selectedGovernorate = value),
///   ),
/// );
/// ```
class GenericListBottomSheet extends StatelessWidget {
  /// List of string items to display.
  final List<String> items;

  /// Optional header title shown above the list.
  final String? title;

  /// Called with the selected item string when the user taps a row.
  /// The sheet is automatically dismissed before the callback fires.
  final ValueChanged<String> onItemSelected;

  const GenericListBottomSheet({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Drag handle ─────────────────────────────────────────────────
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 12.h),

            // ── Optional header ─────────────────────────────────────────────
            if (title != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    title!,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 16.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],

            // ── Items list ──────────────────────────────────────────────────
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Material(
                    color: const Color(0xFFF8F9F9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xFFDADADA),
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1.h,
                        thickness: 1.h,
                        color: const Color(0xFFDADADA),
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            onItemSelected(item);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            child: Text(
                              item,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: const Color(0xFF222222),
                                fontSize: 15.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
