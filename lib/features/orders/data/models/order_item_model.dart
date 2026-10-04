import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.productId,
    required super.name,
    required super.unitPrice,
    required super.imgUrl,
    required super.quantity,
  });

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      productId: entity.productId,
      name: entity.name,
      unitPrice: entity.unitPrice,
      imgUrl: entity.imgUrl,
      quantity: entity.quantity,
    );
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map, String productId) {
    return OrderItemModel(
      productId: productId,
      name: map['name'] as String,
      unitPrice: (map['unitPrice'] as num).toDouble(),
      imgUrl: map['imgUrl'] as String,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'unitPrice': unitPrice,
      'imgUrl': imgUrl,
      'quantity': quantity,
    };
  }
}
