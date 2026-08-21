import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/core/const/splash_const.dart';
import 'package:rooh/shared/widgets/app_button.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'Loginscreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset(logoAsset, height: SplashConstants.logoHeight),
            const SizedBox(height: 35),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 85),
                  height: 590,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: colors.secondary,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'روح',
                        style: TextStyle(
                          color: colors.onSurface,
                          fontFamily: fontFamily,
                          fontSize: SplashConstants.titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: SplashConstants.spacingTitleToSubtitle,
                      ),
                      Text(
                        'من فكرتك... لقطعة لها روح',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: SplashConstants.subtitleFontSize,
                          fontWeight: FontWeight.w400,
                          color: colors.onSurface.withOpacity(
                            SplashConstants.subtitleOpacity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          AppButton(
                            text: 'بائع',
                            icon: Icon(Icons.person),
                            width: 105,
                          ),
                          const SizedBox(width: 3),
                          AppButton(
                            text: 'شاري',
                            icon: Icon(Icons.person),
                            width: 105,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      AppButton(text: 'Sign in With Google'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
