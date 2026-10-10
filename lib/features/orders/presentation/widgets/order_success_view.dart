import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/shared/widgets/app_button.dart';
import '../extensions/order_extensions.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 90,
                    color: colors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'تم استلام طلبك',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'رقم الطلب: #${shortOrderId(orderId)}',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'هنتواصل معاك على رقم الموبايل لتأكيد الطلب',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      color: colors.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 28),
                  AppButton(
                    text: 'العودة للمتجر',
                    onTap: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}