import 'package:equatable/equatable.dart';
import 'order_item_entity.dart';
import 'shipping_info_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<OrderItemEntity> items;
  final double totalPrice;
  final ShippingInfoEntity shippingInfo;
  final String status;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.shippingInfo,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    totalPrice,
    shippingInfo,
    status,
    createdAt,
  ];
}
