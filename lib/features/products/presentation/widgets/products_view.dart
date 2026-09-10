import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rooh/features/products/presentation/widgets/phone_product_card.dart';
import 'package:rooh/features/products/presentation/widgets/product_card.dart';
import '../../../../core/const/app_const.dart';
import '../../../../shared/screens/intro_screen.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/edit_name_dialog.dart';
import '../../../auth/presentation/cubits/authcubit/auth_cubit.dart';
import '../../../auth/presentation/cubits/signout/signout_cubit.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../cubits/cubit/products_cubit.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

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
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (_) => const IntroScreen()),
              );
            },
            onLoginTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            onEditName: () {
              final authState = context.read<AuthCubit>().state;
              if (authState is Authenticated) {
                showEditNameDialog(
                  context: context,
                  currentName: authState.user.userName,
                );
              }
            },
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            onPressed: () =>
                                Scaffold.of(context).openEndDrawer(),
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
                              hintText: '...ابحث عن منتجك',
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
                  final isMobile = ResponsiveBreakpoints.of(context).isMobile;

                  return isMobile
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => PhoneProductCard(
                              productsEntity: products[index],
                            ),
                            childCount: products.length,
                          ),
                        )
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                ProductCard(productsEntity: products[index]),
                            childCount: products.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    ResponsiveBreakpoints.of(context).isDesktop
                                    ? 5
                                    : 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                              ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
