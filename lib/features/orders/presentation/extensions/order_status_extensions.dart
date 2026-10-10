import 'package:flutter/material.dart';
import 'package:rooh/features/orders/domain/entity/order_status.dart';

extension OrderStatusExtensions on OrderStatus {
  String get label => switch (this) {
    OrderStatus.pending => 'في الانتظار',
    OrderStatus.confirmed => 'تم التأكيد',
    OrderStatus.preparing => 'قيد التجهيز',
    OrderStatus.shipped => 'تم الشحن',
    OrderStatus.delivered => 'تم التوصيل',
    OrderStatus.cancelled => 'ملغي',
  };

  Color get color => switch (this) {
    OrderStatus.pending => const Color(0xFFB7791F),
    OrderStatus.confirmed => const Color(0xFF2B6CB0),
    OrderStatus.preparing => const Color(0xFF6B46C1),
    OrderStatus.shipped => const Color(0xFFC66B44),
    OrderStatus.delivered => const Color(0xFF2F855A),
    OrderStatus.cancelled => const Color(0xFFC53030),
  };
}