import 'package:equatable/equatable.dart';
import 'order_item_entity.dart';
import 'order_status.dart';
import 'shipping_info_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<OrderItemEntity> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final ShippingInfoEntity shippingInfo;
  final OrderStatus status;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.shippingInfo,
    required this.status,
    required this.createdAt,
  });

  int get itemsCount => items.fold(0, (sum, i) => sum + i.quantity);

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    subtotal,
    deliveryFee,
    total,
    shippingInfo,
    status,
    createdAt,
  ];
}