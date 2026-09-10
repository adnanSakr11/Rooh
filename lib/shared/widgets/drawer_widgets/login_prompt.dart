import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/const/app_const.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key, 
    required this.colors,
    required this.isMobile,
    required this.onTap,
  });

  final ColorScheme colors;
  final bool isMobile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 28,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 14 : 16,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.person_crop_circle,
                color: colors.surface,
                size: isMobile ? 20 : 22,
              ),
              const SizedBox(width: 10),
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: colors.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

