import 'package:equatable/equatable.dart';
import 'package:rooh/core/utils/money.dart';
import 'order_item_entity.dart';
import 'shipping_info_entity.dart';

class PlaceOrderParams extends Equatable {
  static const double flatDeliveryFee = 0;

  final String orderId;
  final List<OrderItemEntity> items;
  final ShippingInfoEntity shippingInfo;

  const PlaceOrderParams({
    required this.orderId,
    required this.items,
    required this.shippingInfo,
  });

  double get subtotal =>
      roundMoney(items.fold<double>(0, (sum, i) => sum + i.subtotal));
  double get deliveryFee => flatDeliveryFee;
  double get total => roundMoney(subtotal + deliveryFee);

  @override
  List<Object?> get props => [orderId, items, shippingInfo];
}