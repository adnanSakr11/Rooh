import 'package:flutter/material.dart';

import '../../../../core/const/app_const.dart';

class TrustRow extends StatelessWidget {
  const TrustRow({super.key, required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.local_shipping_outlined, 'شحن مجاني'),
      (Icons.replay_outlined, 'إرجاع خلال 14 يوم'),
      (Icons.verified_outlined, 'ضمان الجودة'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) {
        return Column(
          children: [
            Icon(item.$1, color: colors.onSurface.withOpacity(0.6)),
            const SizedBox(height: 6),
            Text(
              item.$2,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 11,
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
