import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/api/api_client.dart';
import '../../../core/widgets/password_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/repositories/profile_repository.dart';
import 'cubits/change_password_cubit.dart';
import 'cubits/change_password_state.dart';
import 'confirm_password_reset_screen.dart';
import 'widgets/profile_header.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _doPasswordsMatch = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePasswords);
    _confirmPasswordController.addListener(_validatePasswords);
  }

  void _validatePasswords() {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    setState(() {
      _doPasswordsMatch = newPass.isNotEmpty && confirmPass.isNotEmpty && newPass == confirmPass;
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ChangePasswordCubit>().requestOTP(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(ProfileRepository(ApiClient())),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordOTPSent) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (innerContext) => BlocProvider.value(
                  value: context.read<ChangePasswordCubit>(),
                  child: ConfirmPasswordResetScreen(
                    email: widget.email,
                    newPassword: _newPasswordController.text,
                  ),
                ),
              ),
            );
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9F9),
            body: Column(
              children: [
                const ProfileHeader(title: 'حسابي'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'تغيير كلمة المرور',
                            style: TextStyle(
                              color: const Color(0xFF222222),
                              fontSize: 20.sp,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          PasswordTextField(
                            labelText: 'كلمة المرور الجديدة',
                            hintText: 'ادخل كلمة المرور الجديدة',
                            controller: _newPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال كلمة المرور الجديدة';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          PasswordTextField(
                            labelText: 'تأكيد كلمة المرور',
                            hintText: 'ادخل تأكيد كلمة المرور',
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال تأكيد كلمة المرور';
                              }
                              if (value != _newPasswordController.text) {
                                return 'كلمة المرور غير متطابقة';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          if (_doPasswordsMatch) _buildSuccessBanner(),
                          SizedBox(height: 48.h),
                          PrimaryButton(
                            label: state is ChangePasswordLoading ? '' : 'حفظ وإرسال الرمز',
                            onPressed: state is ChangePasswordLoading ? null : () => _onSave(context),
                            backgroundColor: const Color(0xFF27AE60),
                          ),
                          if (state is ChangePasswordLoading)
                            const Center(child: CircularProgressIndicator(color: Color(0xFF27AE60))),
                          SizedBox(height: 16.h),
                          _buildCancelButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccessBanner() {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FFF2),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: const Color(0xFF27AE60), width: 1.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'تطابق كلمة المرور!',
            style: TextStyle(
              color: const Color(0xFF444444),
              fontSize: 15.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF27AE60),
            size: 20.r,
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return OutlinedButton(
      onPressed: () => Navigator.pop(context),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.h),
        side: BorderSide(color: const Color(0xFF27AE60), width: 1.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        backgroundColor: const Color(0xFFF8F9F9),
      ),
      child: Text(
        'الغاء',
        style: TextStyle(
          color: const Color(0xFF27AE60),
          fontSize: 18.sp,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
