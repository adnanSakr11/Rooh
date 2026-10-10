import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/shared/widgets/app_button.dart';

class OrdersErrorView extends StatelessWidget {
  const OrdersErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 64,
              color: colors.onSurface.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                color: colors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(text: 'إعادة المحاولة', width: 220, onTap: onRetry),
          ],
        ),
      ),
    );
  }
}
