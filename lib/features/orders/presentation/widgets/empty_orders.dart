import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

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
              Icons.receipt_long_outlined,
              size: 70,
              color: colors.onSurface.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 16),
            Text(
              'لسه معملتش أي طلب',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'أول ما تطلب هتلاقي طلباتك هنا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}