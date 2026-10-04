import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:rooh/features/cart/presentation/screens/cart_screen.dart';
import 'package:rooh/features/orders/presentation/screens/orders_screen.dart';
import 'package:rooh/features/products/presentation/screens/products_screen.dart';
import 'package:rooh/shared/widgets/show_login_required_sheet.dart';

import '../widgets/custom_gnav.dart';

enum IntroTab { products, cart, orders }

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  late final List<Widget> _pages = const [
    ProductsScreen(),
    CartScreen(),
    OrdersScreen(),
  ];

  int _selectedIndex = IntroTab.products.index;

  int _navResetCount = 0;

  void _onTabChange(int index) {
    final isOrders = index == IntroTab.orders.index;
    final isGuest = context.read<AuthCubit>().state is Unauthenticated;

    if (isOrders && isGuest) {
      showLoginRequiredSheet(context);
      setState(() => _navResetCount++);
      return;
    }

    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CustomNavButton(
          key: ValueKey(_navResetCount),
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}