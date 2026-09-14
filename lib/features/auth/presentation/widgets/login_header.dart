import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Image.asset(logoAsset, height: 90),
        const SizedBox(height: 18),
        Text(
          'روح',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'سجّل دخولك وحول فكرتك لقطعة لها روح',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            color: colors.onSurface.withOpacity(0.65),
          ),
        ),
      ],
    );
  }
}