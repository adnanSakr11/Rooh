import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/features/auth/domain/usecases/sign_out_usecasse.dart';
import 'package:rooh/features/auth/domain/usecases/update_user_name.dart';
import 'package:rooh/features/auth/presentation/cubits/signout/signout_cubit.dart';
import 'package:rooh/features/auth/presentation/cubits/update_user_name/update_user_name_cubit.dart';
import 'package:rooh/features/products/domain/usecases/fetch_images_on_pexels_usecase.dart';
import 'package:rooh/features/products/domain/usecases/search_app_products.dart';
import 'package:rooh/features/products/presentation/cubits/cubit/products_cubit.dart';
import '../../../../core/injection/service_locator.dart';
import '../widgets/products_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsCubit(
            getIt<FetchImagesOnPexelsUsecase>(),
            getIt<SearchAppProductsUsecase>(),
          )..loadingProducts(),
        ),
        BlocProvider(create: (_) => SignoutCubit(getIt<SignOutUsecasse>())),
        BlocProvider(
          create: (_) => UpdateUserNameCubit(getIt<UpdateUserNameUsecase>()),
        ),
      ],
      child: const ProductsView(),
    );
  }
}
