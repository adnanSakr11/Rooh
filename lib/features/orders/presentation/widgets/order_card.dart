import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/core/utils/money.dart';
import 'package:rooh/features/orders/domain/entity/order_entity.dart';

import '../extensions/order_extensions.dart';
import 'order_status_chip.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, this.onTap});

  final OrderEntity order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.primary.withValues(alpha: 0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderStatusChip(status: order.status),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'طلب #${order.shortId}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              order.formattedDate,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.total.asEgp,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: colors.primary,
                  ),
                ),
                Text(
                  'عدد المنتجات: ${order.itemsCount}',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    color: colors.onSurface.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}