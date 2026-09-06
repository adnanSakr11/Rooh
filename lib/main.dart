import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/core/theme/app_theme.dart';
import 'package:rooh/features/cart/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:rooh/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:rooh/features/cart/domain/usecases/remove_item_from_cart.dart';
import 'package:rooh/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:rooh/features/cart/domain/usecases/watch_cart_usecase.dart';
import 'package:rooh/features/cart/presentation/cubits/cart/cart_cubit.dart';
import 'package:rooh/features/products/domain/usecases/fetch_images_on_pexels_usecase.dart';
import 'package:rooh/shared/screens/splash_screen.dart';
import 'package:rooh/shared/screens/intro_screen.dart';
import 'package:rooh/shared/screens/swipe_up.dart';
import 'core/injection/service_locator.dart';
import 'features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupAuthDependencies();
  setupProductsDependencies();
  setupCartDependencies();

  runApp(const Rooh());
}

class Rooh extends StatelessWidget {
  const Rooh({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(getIt<WatchAuthStateUsecase>()),

      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => CartCubit(
              getIt<WatchCartUsecase>(),
              getIt<AddItemToCartUsecase>(),
              getIt<RemoveItemFromCartUsecase>(),
              getIt<UpdateCartQuantityUsecase>(),
              getIt<ClearCartUsecase>(),
              getIt<FetchImagesOnPexelsUsecase>(),
              context.read<AuthCubit>(),
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appTheme,
              builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                    start: 1921,
                    end: double.infinity,
                    name: '4K',
                  ),
                ],
              ),
              home: Builder(
                builder: (context) {
                  return SplashScreen(
                    onContinue: () => Navigator.pushReplacement(
                      context,
                      SwipeUpPageRoute(builder: (_) => const IntroScreen()),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
