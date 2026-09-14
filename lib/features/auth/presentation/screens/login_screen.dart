import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/features/auth/domain/usecases/signin_with_google.dart';
import 'package:rooh/features/auth/domain/usecases/signin_with_phone_and_pass.dart';
import 'package:rooh/features/auth/presentation/cubits/google_signin_cubit/google_signin_cubit.dart';
import 'package:rooh/features/auth/presentation/cubits/phone_signin/phone_signin_cubit.dart';
import 'package:rooh/features/auth/presentation/widgets/google_signin_button.dart';
import 'package:rooh/features/auth/presentation/widgets/login_header.dart';
import 'package:rooh/features/auth/presentation/widgets/or_divider.dart';
import 'package:rooh/features/auth/presentation/widgets/phone_signin_form.dart';
import 'package:rooh/core/const/app_const.dart';
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

class _LoginView extends StatelessWidget {
  const _LoginView();

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
        backgroundColor: colors.surface,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),
                    const SizedBox(height: 40),
                    const GoogleSigninButton(),
                    const SizedBox(height: 28),
                    const OrDivider(),
                    const SizedBox(height: 28),
                    const PhoneSigninForm(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
