import 'package:flutter/material.dart';

class QtyButton extends StatelessWidget {
  const QtyButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: colors.primary.withOpacity(0.9),
          border: Border.all(color: colors.onSurface),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, size: 16, color: colors.onSurface),
      ),
    );
  }
}
