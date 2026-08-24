import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rooh/core/theme/app_theme.dart';
import 'package:rooh/features/auth/presentation/screens/splash_screen.dart';
import 'package:rooh/shared/screens/intro_screen.dart';
import 'package:rooh/shared/screens/swipe_up.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Rooh());
}

class Rooh extends StatelessWidget {
  const Rooh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Builder(
        builder: (context) {
          return SplashScreen(
            onContinue: () => Navigator.pushReplacement(
              context,
              SwipeUpPageRoute(builder: (_) => const IntroPage()),
            ),
          );
        },
      ),
    );
  }
}
