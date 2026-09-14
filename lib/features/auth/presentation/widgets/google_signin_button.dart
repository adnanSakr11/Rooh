import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/cubits/google_signin_cubit/google_signin_cubit.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleSigninCubit, GoogleSigninState>(
      builder: (context, state) {
        final isLoading = state is GoogleSiginLoading;

        return GestureDetector(
          onTap: isLoading
              ? null
              : () => context.read<GoogleSigninCubit>().googleSignin(),
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
      },
    );
  }
}