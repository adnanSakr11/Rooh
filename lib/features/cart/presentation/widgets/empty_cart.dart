import 'package:flutter/material.dart';

import '../../../../core/const/app_const.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key, required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 70,
            color: colors.onSurface.withOpacity(0.25),
          ),
          const SizedBox(height: 16),
          Text(
            'السلة فاضية',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
