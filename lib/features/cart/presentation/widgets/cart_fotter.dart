import 'package:flutter/material.dart';

import '../../../../core/const/app_const.dart';
import '../../../../shared/widgets/app_button.dart';

class CartFooter extends StatelessWidget {
  const CartFooter({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الإجمالي',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    '${totalPrice.toStringAsFixed(0)} جنيه',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AppButton(
                text: 'إتمام الطلب',
                onTap: () {
                  // فيتشر Orders لسه هيتعمل بعدين
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


