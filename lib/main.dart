import 'package:flutter/material.dart';
import 'package:rooh/features/auth/presentation/screens/splash_screen.dart';

void main() {
  runApp(Rooh());
}

class Rooh extends StatelessWidget {
  const Rooh({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen() ,
    );
  }
}
