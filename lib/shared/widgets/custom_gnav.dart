import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavButton extends StatelessWidget {
  void Function(int)? onTabChange;
  final int unreadMessagesCount;
  final int friendRequestsCount;

  CustomNavButton({
    super.key,
    required this.onTabChange,
    this.unreadMessagesCount = 0,
    this.friendRequestsCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 5, left: 8),
      child: GNav(
        padding: EdgeInsetsGeometry.all(20),
        gap: 2,
        onTabChange: (value) => onTabChange!(value),
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

          // GButton(
          //   icon: Icons.notifications_outlined,
          //   text: 'طلباتك',
          //   textColor: colors.onSurface,
          //   iconActiveColor: colors.onSurface,
          //   iconColor: colors.onSurface,

          // GButton(
          //   icon: Icons.settings,
          //   text: 'المجتمع',
          //   textColor: colors.onSurface,
          //   iconActiveColor: colors.onSurface,
          //   iconColor: colors.onSurface,
          // ),
        ],
      ),
    );
  }
}
