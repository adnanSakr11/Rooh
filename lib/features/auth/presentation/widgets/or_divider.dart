import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final line = Expanded(
      child: Container(height: 1, color: colors.onSurface.withOpacity(0.15)),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'أو',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: colors.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        line,
      ],
    );
  }
}