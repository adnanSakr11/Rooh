import 'package:flutter/material.dart';
import 'package:rooh/features/cart/presentation/screens/cart_screen.dart';
import 'package:rooh/features/products/presentation/screens/products_screen.dart';

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
  }

  List<Widget> get pages => [const ProductsScreen(), const CartScreen()];

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
