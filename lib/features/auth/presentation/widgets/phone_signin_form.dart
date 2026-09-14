import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/cubits/phone_signin/phone_signin_cubit.dart';

import 'auth_text_field.dart';

class PhoneSigninForm extends StatefulWidget {
  const PhoneSigninForm({super.key});

  @override
  State<PhoneSigninForm> createState() => _PhoneSigninFormState();
}

class _PhoneSigninFormState extends State<PhoneSigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<PhoneSigninCubit>().phoneSignin(
      _phoneController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            controller: _phoneController,
            hintText: 'رقم الهاتف',
            prefixIcon: Icon(
              CupertinoIcons.phone,
              color: colors.onSurface.withOpacity(0.6),
              size: 20,
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'من فضلك أدخل رقم الهاتف';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: _passwordController,
            hintText: 'كلمة المرور',

            obscureText: _obscurePassword,
            prefixIcon: IconButton(
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword
                    ? CupertinoIcons.eye_slash
                    : CupertinoIcons.eye,
                color: colors.onSurface.withOpacity(0.6),
                size: 20,
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'كلمة المرور 6 أحرف على الأقل';
              }
              return null;
            },
          ),
          const SizedBox(height: 26),
          BlocBuilder<PhoneSigninCubit, PhoneSigninState>(
            builder: (context, state) {
              final isLoading = state is PhoneSigninLoading;
              return GestureDetector(
                onTap: isLoading ? null : _submit,
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: colors.surface,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
