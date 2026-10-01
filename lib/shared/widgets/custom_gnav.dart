import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavButton extends StatelessWidget {
  const CustomNavButton({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 5, left: 8),
      child: GNav(
        selectedIndex: selectedIndex,
        padding: const EdgeInsets.all(20),
        gap: 2,
        onTabChange: onTabChange,
        mainAxisAlignment: MainAxisAlignment.center,
        color: colors.onSurface,
        activeColor: colors.onPrimary,
        tabActiveBorder: Border.all(color: colors.primary),
        tabBackgroundColor: colors.surface,
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: 'المنتجات',
            textColor: colors.onSurface,
            iconActiveColor: colors.primary,
            iconColor: colors.onSurface,
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: 'العربة',
            textColor: colors.onSurface,
            iconActiveColor: colors.primary,
            iconColor: colors.onSurface,
          ),
          GButton(
            icon: Icons.notifications_outlined,
            text: 'طلباتك',
            textColor: colors.onSurface,
            iconActiveColor: colors.onSurface,
            iconColor: colors.onSurface,
          ),
        ],
      ),
    );
  }
}
