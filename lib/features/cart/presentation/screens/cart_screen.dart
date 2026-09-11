import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import '../cubits/cart/cart_cubit.dart';
import '../widgets/cart_fotter.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          'السلة',
          style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading || state is CartInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontFamily: fontFamily),
              ),
            );
          }

          final loaded = state as CartLoaded;

          if (loaded.items.isEmpty) {
            return EmptyCart(colors: colors);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: loaded.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CartItemTile(item: loaded.items[index]);
                  },
                ),
              ),
              CartFooter(totalPrice: loaded.totalPrice),
            ],
          );
        },
      ),
    );
  }
}







