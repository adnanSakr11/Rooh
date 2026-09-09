import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colors.surface,
      ),
      padding: EdgeInsets.only(bottom: 14, top: 5),
      child: GNav(
        gap: 2,
        onTabChange: (value) => onTabChange!(value),
        mainAxisAlignment: MainAxisAlignment.center,
        color: colors.onSurface,
        activeColor: colors.onPrimary,
        tabActiveBorder: Border.all(color: colors.primary),
        tabBackgroundColor: colors.surface,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'المنتجات',
            textColor: colors.onSurface,
            iconActiveColor: colors.onSurface,
            iconColor: colors.onSurface,
            leading: unreadMessagesCount > 0
                ? _buildBadge(
                    icon: Icons.home,
                    count: unreadMessagesCount,
                    color: colors.onSurface,
                  )
                : null,
          ),

          GButton(
            icon: Icons.shopping_cart_outlined,
            text: 'العربة',
            textColor: colors.onSurface,
            iconActiveColor: colors.onSurface,
            iconColor: colors.onSurface,
          ),

          // GButton(
          //   icon: Icons.notifications_outlined,
          //   text: 'طلباتك',
          //   textColor: colors.onSurface,
          //   iconActiveColor: colors.onSurface,
          //   iconColor: colors.onSurface,
          //   leading: friendRequestsCount > 0
          //       ? _buildBadge(
          //           icon: Icons.notifications_outlined,
          //           count: friendRequestsCount,
          //           color: colors.onSurface,
          //         )
          //       : null,
          // ),

          // GButton(
          //   icon: Icons.settings,
          //   text: 'Settings',
          //   textColor: colors.onSurface,
          //   iconActiveColor: colors.onSurface,
          //   iconColor: colors.onSurface,
          // ),
        ],
      ),
    );
  }

  /// Helper method to build a badge with icon and count
  Widget _buildBadge({
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: color),
        if (count > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
