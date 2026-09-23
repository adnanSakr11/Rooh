import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:rooh/features/cart/presentation/screens/cart_screen.dart';
import 'package:rooh/features/oredrs/presentation/screens/orders_screen.dart';
import 'package:rooh/features/products/presentation/screens/products_screen.dart';
import 'package:rooh/shared/widgets/show_login_required_sheet.dart';

import '../widgets/custom_gnav.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      final state = context.read<AuthCubit>().state;
      if (state is! Authenticated) {
        showLoginRequiredSheet(context);
      }
    }
  }

  List<Widget> get pages => [
    const ProductsScreen(),
    const CartScreen(),
    const OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CustomNavButton(
          onTabChange: (index) => navigateBottomBar(index),
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
