import 'package:flutter/material.dart';
import 'package:rooh/features/products/presentation/screens/products_screen.dart';

import '../../features/products/presentation/widgets/custom_gnav.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get pages => [ ProductsScreen()];

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
