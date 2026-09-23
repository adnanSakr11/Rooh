import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/const/app_const.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import 'app_button.dart';

void showLoginRequiredSheet(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  showModalBottomSheet(
    context: context,
    backgroundColor: colors.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.lock, size: 40, color: colors.primary),
            const SizedBox(height: 16),
            Text(
              'لازم تسجل دخول الأول',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'سجّل دخولك عشان تقدر تشوف طلباتك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                color: colors.onSurface.withOpacity(0.65),
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'تسجيل الدخول',
              backgroundColor: colors.primary,
              textColor: colors.surface,
              onTap: () {
                Navigator.pop(sheetContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}