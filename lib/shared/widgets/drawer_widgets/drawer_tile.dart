import 'package:flutter/material.dart';

import '../../../core/const/app_const.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({super.key, 
    required this.icon,
    required this.label,
    required this.colors,
    required this.isMobile,
    this.onTap,
    this.isDestructive = false,
  });

  final Widget icon;
  final String label;
  final ColorScheme colors;
  final bool isMobile;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.redAccent : colors.onSurface;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 28,
          vertical: isMobile ? 13 : 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            const SizedBox(width: 14),
            icon,
          ],
        ),
      ),
    );
  }
}
