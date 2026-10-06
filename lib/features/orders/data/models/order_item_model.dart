import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.productId,
    required super.name,
    required super.unitPrice,
    required super.imgUrl,
    required super.quantity,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map['productId'],
      name: map['name'] as String,
      unitPrice: (map['unitPrice'] as num).toDouble(),
      imgUrl: map['imgUrl'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
