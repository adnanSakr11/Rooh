import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/core/utils/money.dart';
import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';
import 'package:rooh/features/orders/domain/entity/place_order_params.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/shared/widgets/app_network_image.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, this.items, this.item});

  final List<OrderItemEntity>? items;
  final ProductsEntity? item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtotal = roundMoney(
      items!.fold<double>(0, (sum, i) => sum + i.subtotal),
    );
    const deliveryFee = PlaceOrderParams.flatDeliveryFee;
    final total = roundMoney(subtotal + deliveryFee);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'ملخص الطلب',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          for (final item in items ?? []) _ItemRow(item: item),
          Divider(color: colors.onSurface.withValues(alpha: 0.1)),
          _AmountRow(label: 'المجموع', value: subtotal.asEgp),
          _AmountRow(
            label: 'التوصيل',
            value: deliveryFee == 0 ? 'مجاني' : deliveryFee.asEgp,
          ),
          _AmountRow(label: 'الإجمالي', value: total.asEgp, emphasized: true),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.item});

  final OrderItemEntity item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppNetworkImage(
              url: item.imgUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: colors.onSurface,
                  ),
                ),
                Text(
                  'الكمية: ${item.quantity}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            item.subtotal.asEgp,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final style = TextStyle(
      fontFamily: fontFamily,
      fontWeight: emphasized ? FontWeight.bold : FontWeight.w500,
      fontSize: emphasized ? 18 : 15,
      color: emphasized ? colors.primary : colors.onSurface,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: style),
          Text(label, style: style),
        ],
      ),
    );
  }
}
