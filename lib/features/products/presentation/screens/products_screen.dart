import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/auth/presentation/cubits/signout/signout_cubit.dart';
import 'package:rooh/features/products/data/repo/products_repo.dart';
import 'package:rooh/features/products/domain/usecases/fetch_images_on_pexels_usecase.dart';
import 'package:rooh/features/products/domain/usecases/search_app_products.dart';
import 'package:rooh/features/products/presentation/cubits/cubit/products_cubit.dart';
import 'package:rooh/shared/screens/splash_screen.dart';
import 'package:rooh/shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProductRepositoryImpl();

    return BlocProvider(
      create: (_) => ProductsCubit(
        FetchImagesOnPexelsUsecase(repository),
        SearchAppProductsUsecase(),
      )..loadingProducts(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      endDrawer: BlocBuilder<SignoutCubit, SignoutState>(
        builder: (context, state) {
          return AppDrawer(
            onSignOut: () async {
              await context.read<SignoutCubit>().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SplashScreen()),
              );
            },
            onLoginTap: () {
              Navigator.pop(context); // قفل الدراور
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 35),
                Row(
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                        icon: Icon(
                          Icons.person_outline,
                          size: 28,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: AppSearchBar(
                          fillColor: colors.surface,
                          hintText: 'ابحث عن منتجك',
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: colors.onSurface,
                            size: 28,
                          ),
                          onChanged: (query) {
                            context.read<ProductsCubit>().search(query);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'المنتجات',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          BlocBuilder<ProductsCubit, ProductsStates>(
            builder: (context, state) {
              if (state is ProductsLoading || state is ProductsInitial) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is ProductsError) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                );
              }

              final products = (state as ProductsLoaded).displayedProducts;
              final crossAxisCount = ResponsiveBreakpoints.of(context).isDesktop
                  ? 5
                  : ResponsiveBreakpoints.of(context).isTablet
                  ? 3
                  : 2;

              return SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(productsModel: products[index]);
                  }, childCount: products.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
