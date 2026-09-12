import 'package:flutter/material.dart';
import '../../../../core/const/app_const.dart';
import '../../../products/presentation/extensions/products_extensions.dart';
import '../models/cart_item_view.dart';
import 'quantity_controls.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});

  final CartItemView item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: colors.primary.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.product.imageUrl,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: colors.onSurface.withOpacity(0.05),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: colors.onSurface.withOpacity(0.3),
                ),
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.product.formattedPrice,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: colors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          QuantityControls(item: item),
        ],
      ),
    );
  }
}
