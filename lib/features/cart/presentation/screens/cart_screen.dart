import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/presentation/models/cart_item_view.dart';
import 'package:rooh/shared/widgets/app_button.dart';

import '../cubits/cart/cart_cubit.dart';

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
            return _EmptyCart(colors: colors);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: loaded.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _CartItemTile(item: loaded.items[index]);
                  },
                ),
              ),
              _CartFooter(totalPrice: loaded.totalPrice),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 70,
            color: colors.onSurface.withOpacity(0.25),
          ),
          const SizedBox(height: 16),
          Text(
            'السلة فاضية',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({required this.item});

  final CartItemView item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.onSurface.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.product.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                color: colors.onSurface.withOpacity(0.05),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: colors.onSurface.withOpacity(0.3),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.product.formattedPrice,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _QuantityControls(item: item),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              final result = await context.read<CartCubit>().removeFromCart(
                item.product.id,
              );
              if (context.mounted) {
                _showErrorIfAny(context, result);
              }
            },
            icon: Icon(Icons.close, color: colors.onSurface.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}

class _QuantityControls extends StatelessWidget {
  const _QuantityControls({required this.item});

  final CartItemView item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        _QtyButton(
          icon: Icons.remove,
          onTap: () async {
            final result = await context.read<CartCubit>().updateQuantity(
              item.product.id,
              item.quantity - 1,
            );
            if (context.mounted) _showErrorIfAny(context, result);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${item.quantity}',
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),
        ),
        _QtyButton(
          icon: Icons.add,
          onTap: () async {
            final result = await context.read<CartCubit>().updateQuantity(
              item.product.id,
              item.quantity + 1,
            );
            if (context.mounted) _showErrorIfAny(context, result);
          },
        ),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.primary.withOpacity(0.4)),
        ),
        child: Icon(icon, size: 16, color: colors.primary),
      ),
    );
  }
}

class _CartFooter extends StatelessWidget {
  const _CartFooter({required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الإجمالي',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    '${totalPrice.toStringAsFixed(0)} جنيه',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AppButton(
                text: 'إتمام الطلب',
                onTap: () {
                  // فيتشر Orders لسه هيتعمل بعدين
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showErrorIfAny(BuildContext context, Either<Failure, void> result) {
  result.fold(
    (failure) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          failure.message,
          style: TextStyle(fontFamily: fontFamily),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    ),
    (_) {},
  );
}
