import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onLoginTap,
    this.onEditName,
    this.onSignOut,
    this.onMyOrders,
    this.onAboutStore,
    this.onContactUs,
  });

  final VoidCallback onLoginTap;
  final VoidCallback? onEditName;
  final VoidCallback? onSignOut;
  final VoidCallback? onMyOrders;
  final VoidCallback? onAboutStore;
  final VoidCallback? onContactUs;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final drawerWidth = isMobile
        ? MediaQuery.of(context).size.width * 0.82
        : 340.0;

    return Drawer(
      width: drawerWidth,
      backgroundColor: colors.secondary,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 25),
                if (state is Authenticated)
                  _AuthenticatedHeader(
                    userName: state.user.userName,
                    colors: colors,
                    isMobile: isMobile,
                    onEditName: onEditName,
                  )
                else ...[
                  Center(
                    child: _LoginPrompt(
                      colors: colors,
                      isMobile: isMobile,
                      onTap: onLoginTap,
                    ),
                  ),
                  _DrawerTile(
                    icon: Icon(
                      CupertinoIcons.info_circle,
                      size: isMobile ? 22 : 24,
                      color: colors.onSurface,
                    ),
                    label: 'عن متجرنا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onAboutStore,
                  ),
                  _DrawerTile(
                    icon: Icon(
                      CupertinoIcons.phone,
                      size: isMobile ? 22 : 24,
                      color: colors.onSurface,
                    ),
                    label: 'تواصل معنا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onContactUs,
                  ),
                  _DrawerTile(
                    icon: Image.asset(
                      'assets/images/social-media-icon.png',
                      height: isMobile ? 22 : 24,
                      width: isMobile ? 22 : 24,
                    ),
                    label: 'السوشيال الميديا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onContactUs,
                  ),
                ],

                // const SizedBox(height: 8),
                // Divider(color: colors.onSurface.withOpacity(0.08), height: 1),
                if (state is Authenticated) ...[
                  const SizedBox(height: 8),
                  _DrawerTile(
                    icon: Icon(
                      CupertinoIcons.bag,
                      size: isMobile ? 22 : 24,
                      color: colors.onSurface,
                    ),
                    label: 'طلباتي',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onMyOrders,
                  ),
                  _DrawerTile(
                    icon: Icon(
                      CupertinoIcons.info_circle,
                      size: isMobile ? 22 : 24,
                      color: colors.onSurface,
                    ),
                    label: 'عن متجرنا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onAboutStore,
                  ),
                  _DrawerTile(
                    icon: Icon(
                      CupertinoIcons.phone,
                      size: isMobile ? 22 : 24,
                      color: colors.onSurface,
                    ),
                    label: 'تواصل معنا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onContactUs,
                  ),
                  const Spacer(),
                  Divider(color: colors.onSurface.withOpacity(0.08), height: 1),
                  _DrawerTile(
                    icon: Icon(
                      CupertinoIcons.square_arrow_right,
                      size: isMobile ? 22 : 24,
                      color: colors.onSurface,
                    ),
                    label: 'تسجيل الخروج',
                    colors: colors,
                    isMobile: isMobile,
                    isDestructive: true,
                    onTap: onSignOut,
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AuthenticatedHeader extends StatelessWidget {
  const _AuthenticatedHeader({
    required this.userName,
    required this.colors,
    required this.isMobile,
    required this.onEditName,
  });

  final String userName;
  final ColorScheme colors;
  final bool isMobile;
  final VoidCallback? onEditName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 28,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment,
        children: [
          Expanded(
            child: Text(
              userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: isMobile ? 20 : 23,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onEditName,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: colors.onSurface.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.pencil,
                size: isMobile ? 16 : 18,
                color: colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt({
    required this.colors,
    required this.isMobile,
    required this.onTap,
  });

  final ColorScheme colors;
  final bool isMobile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 28,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 14 : 16,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.person_crop_circle,
                color: colors.surface,
                size: isMobile ? 20 : 22,
              ),
              const SizedBox(width: 10),
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: colors.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
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
