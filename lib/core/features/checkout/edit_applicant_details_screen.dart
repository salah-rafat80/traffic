import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffic/core/features/checkout/models/applicant_details.dart';
import 'package:traffic/core/widgets/primary_button.dart';
import 'package:traffic/core/widgets/service_screen_appbar.dart';

/// A generic "Edit Applicant Details" (تعديل البيانات) screen.
///
/// Opened from [GenericOrderReviewScreen] when the user taps "تعديل".
/// Returns the updated [ApplicantDetails] via [Navigator.pop] on save,
/// or pops with `null` on cancel.
class EditApplicantDetailsScreen extends StatefulWidget {
  /// The app-bar title, e.g. 'اصدار بدل فاقد / تالف رخصة قيادة'.
  final String appBarTitle;

  /// The current applicant data to pre-fill the form with.
  final ApplicantDetails currentDetails;

  const EditApplicantDetailsScreen({
    super.key,
    required this.appBarTitle,
    required this.currentDetails,
  });

  @override
  State<EditApplicantDetailsScreen> createState() =>
      _EditApplicantDetailsScreenState();
}

class _EditApplicantDetailsScreenState
    extends State<EditApplicantDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentDetails.name);
    _emailController = TextEditingController(text: widget.currentDetails.email);
    _phoneController = TextEditingController(text: widget.currentDetails.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ── Handlers ──────────────────────────────────────────────────────────────

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final updated = ApplicantDetails(
      name: _nameController.text.trim(),
      nationalId: widget.currentDetails.nationalId, // read-only
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
    );

    Navigator.pop(context, updated);
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  // ── Validators ────────────────────────────────────────────────────────────

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'برجاء إدخال الاسم الكامل';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'برجاء إدخال البريد الالكتروني';
    }
    if (!value.contains('@')) {
      return 'برجاء إدخال بريد الكتروني صحيح';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'برجاء إدخال رقم الهاتف';
    }
    return null;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // ── App bar ───────────────────────────────────────────────────
            ServiceScreenAppBar(title: widget.appBarTitle),

            // ── Scrollable body ───────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section title
                      Text(
                        'تعديل البيانات',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF222222),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // ── Personal Data card ──────────────────────────────
                      const _SectionHeader(title: 'البيانات الشخصية'),
                      SizedBox(height: 8.h),
                      _FormCard(
                        children: [
                          // Editable: Full name
                          _LabeledField(
                            label: 'الاسم الكامل',
                            icon: Icons.person_outline,
                            controller: _nameController,
                            validator: _validateName,
                          ),

                          SizedBox(height: 12.h),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: const Color(0xFFDADADA),
                          ),
                          SizedBox(height: 12.h),

                          // Read-only: National ID
                          _ReadOnlyField(
                            label: 'الرقم القومي',
                            value: widget.currentDetails.nationalId,
                            icon: Icons.badge_outlined,
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // ── Contact Info card ───────────────────────────────
                      const _SectionHeader(title: 'معلومات التواصل'),
                      SizedBox(height: 8.h),
                      _FormCard(
                        children: [
                          // Editable: Email
                          _LabeledField(
                            label: 'البريد الالكتروني',
                            icon: Icons.email_outlined,
                            controller: _emailController,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          // Warning text
                          Padding(
                            padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
                            child: Text(
                              'سيتم إرسال رمز تحقق عند تغيير البريد الالكتروني',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFE53935),
                              ),
                            ),
                          ),

                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: const Color(0xFFDADADA),
                          ),
                          SizedBox(height: 12.h),

                          // Editable: Phone
                          _LabeledField(
                            label: 'رقم الهاتف',
                            icon: Icons.phone_outlined,
                            controller: _phoneController,
                            validator: _validatePhone,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      // ── Save button ─────────────────────────────────────
                      PrimaryButton(
                        label: 'حفظ التغيرات',
                        onPressed: _onSave,
                        backgroundColor: const Color(0xFF27AE60),
                      ),

                      SizedBox(height: 12.h),

                      // ── Cancel button ───────────────────────────────────
                      _OutlinedActionButton(
                        label: 'الغاء',
                        onPressed: _onCancel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Private sub-widgets ─────────────────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════════════════════

/// Section header text (e.g. 'البيانات الشخصية').
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF222222),
      ),
    );
  }
}

/// Card shell used for the two form sections.
class _FormCard extends StatelessWidget {
  final List<Widget> children;
  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFDADADA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

/// A labeled editable text field with an icon, inside a card.
class _LabeledField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

  const _LabeledField({
    required this.label,
    required this.icon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Label row with icon
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(icon, size: 18.sp, color: const Color(0xFF27AE60)),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF707070),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Text field
        TextFormField(
          controller: controller,
          validator: validator,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          keyboardType: keyboardType,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF222222),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: const BorderSide(color: Color(0xFFDADADA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: const BorderSide(
                color: Color(0xFF27AE60),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: const BorderSide(color: Color(0xFFE53935)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: const BorderSide(
                color: Color(0xFFE53935),
                width: 1.5,
              ),
            ),
            errorStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFE53935),
            ),
          ),
        ),
      ],
    );
  }
}

/// Read-only field with a "غير قابل للتعديل" badge.
class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ReadOnlyField({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Label row with icon
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Label + icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18.sp, color: const Color(0xFF707070)),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF707070),
                  ),
                ),
              ],
            ),

            // Badge: غير قابل للتعديل
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                'غير قابل للتعديل',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF707070),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Value text (non-editable)
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}

/// Green-outlined cancel button matching the Figma design.
class _OutlinedActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _OutlinedActionButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9F9),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF27AE60)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF27AE60),
            ),
          ),
        ),
      ),
    );
  }
}
