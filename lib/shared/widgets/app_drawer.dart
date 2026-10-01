import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:rooh/shared/widgets/drawer_widgets/auth_header.dart';

import 'drawer_widgets/drawer_tile.dart';
import 'drawer_widgets/login_prompt.dart';

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
                  AuthenticatedHeader(
                    userName: state.user.userName,
                    colors: colors,
                    isMobile: isMobile,
                    onEditName: onEditName,
                  )
                else ...[
                  Center(
                    child: LoginPrompt(
                      colors: colors,
                      isMobile: isMobile,
                      onTap: onLoginTap,
                    ),
                  ),
                  DrawerTile(
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
                  DrawerTile(
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
                  DrawerTile(
                    icon: Image.asset(
                      socialIcon,
                      height: isMobile ? 22 : 24,
                      width: isMobile ? 22 : 24,
                    ),
                    label: 'السوشيال الميديا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onContactUs,
                  ),
                ],

                if (state is Authenticated) ...[
                  const SizedBox(height: 8),
                  DrawerTile(
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
                  DrawerTile(
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
                  DrawerTile(
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
                  DrawerTile(
                    icon: Image.asset(
                      socialIcon,
                      height: isMobile ? 22 : 24,
                      width: isMobile ? 22 : 24,
                    ),
                    label: 'السوشيال الميديا',
                    colors: colors,
                    isMobile: isMobile,
                    onTap: onContactUs,
                  ),
                  const Spacer(),
                  Divider(color: colors.onSurface.withOpacity(0.08), height: 1),
                  DrawerTile(
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
