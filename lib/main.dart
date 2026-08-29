import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/core/theme/app_theme.dart';
import 'package:rooh/shared/screens/splash_screen.dart';
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
      builder: (context, child) => ResponsiveBreakpoints.builder
      (
        child: child!, 
        breakpoints:[
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ]
      ),
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
