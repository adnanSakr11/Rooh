import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/features/cart/presentation/widgets/qty_button.dart';

import '../../../../core/const/app_const.dart';
import '../../../../core/errors/failure.dart';
import '../cubits/cart/cart_cubit.dart';
import '../models/cart_item_view.dart';

class QuantityControls extends StatelessWidget {
  const QuantityControls({super.key, required this.item});

  final CartItemView item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bool isSmallerThanOne = item.quantity == 1;

    return Column(
      children: [
        QtyButton(
          icon: Icons.add,
          onTap: () async {
            final result = await context.read<CartCubit>().updateQuantity(
              item.product.id,
              item.quantity + 1,
            );
            if (context.mounted) _showErrorIfAny(context, result);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.primary, width: 2),
            ),
            child: Center(
              child: Text(
                '${item.quantity}',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: colors.onSurface,
                ),
              ),
            ),
          ),
        ),
        QtyButton(
          icon: isSmallerThanOne ? Icons.delete_forever_rounded : Icons.remove,
          onTap: () async {
            final result = await context.read<CartCubit>().updateQuantity(
              item.product.id,
              item.quantity - 1,
            );
            if (context.mounted) _showErrorIfAny(context, result);
          },
        ),
      ],
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
