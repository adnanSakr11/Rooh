import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/features/orders/domain/entity/order_status.dart';

import '../extensions/order_status_extensions.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}