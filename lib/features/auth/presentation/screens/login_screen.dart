import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/domain/usecases/signin_with_google.dart';
import 'package:rooh/features/auth/domain/usecases/signin_with_phone_and_pass.dart';
import 'package:rooh/features/auth/presentation/cubits/google_signin_cubit/google_signin_cubit.dart';
import 'package:rooh/features/auth/presentation/cubits/phone_signin/phone_signin_cubit.dart';

import '../../../../core/injection/service_locator.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'Loginscreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GoogleSigninCubit(getIt<SigninWithGoogleUsecase>()),
        ),
        BlocProvider(
          create: (_) =>
              PhoneSigninCubit(getIt<SigninWithPhoneAndPassUsecase>()),
        ),
      ],
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
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

  void _submitPhoneForm() {
    if (!_formKey.currentState!.validate()) return;
    context.read<PhoneSigninCubit>().phoneSignin(
      _phoneController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleSigninCubit, GoogleSigninState>(
          listener: (context, state) {
            if (state is GoogleSiginSucces) {
              Navigator.pop(context);
            } else if (state is GoogleSiginError) {
              _showError(context, state.message);
            }
          },
        ),
        BlocListener<PhoneSigninCubit, PhoneSigninState>(
          listener: (context, state) {
            if (state is PhoneSigninSuccess) {
              Navigator.pop(context);
            } else if (state is PhoneSigninError) {
              _showError(context, state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: colors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(CupertinoIcons.xmark, color: Colors.white),
                    alignment: Alignment.centerRight,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(logoAsset, height: 90),
                  const SizedBox(height: 18),
                  Text(
                    'روح',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'سجّل دخولك وحول فكرتك لقطعة لها روح',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<GoogleSigninCubit, GoogleSigninState>(
                    builder: (context, state) {
                      return _GoogleButton(
                        isLoading: state is GoogleSiginLoading,
                        onTap: () =>
                            context.read<GoogleSigninCubit>().googleSignin(),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const _OrDivider(),
                  const SizedBox(height: 28),
                  _AuthTextField(
                    controller: _phoneController,
                    hintText: 'رقم الهاتف',
                    icon: CupertinoIcons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'من فضلك أدخل رقم الهاتف';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  _AuthTextField(
                    controller: _passwordController,
                    hintText: 'كلمة المرور',
                    icon: CupertinoIcons.lock,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: Colors.white.withOpacity(0.7),
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
                      return _SubmitButton(
                        isLoading: state is PhoneSigninLoading,
                        colors: colors,
                        onTap: _submitPhoneForm,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontFamily: fontFamily)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
          return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.4),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(googleIcon, height: 20, width: 20),
                  const SizedBox(width: 12),
                  Text(
                    'المتابعة بحساب جوجل',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Container(height: 1, color: Colors.white.withOpacity(0.25)),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'أو',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        line,
      ],
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          color: Colors.white.withOpacity(0.6),
        ),
        prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(color: Colors.yellowAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white, width: 1.4),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoading,
    required this.colors,
    required this.onTap,
  });

  final bool isLoading;
  final ColorScheme colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: colors.primary,
                ),
              )
            : Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
      ),
    );
  }
}
