import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooh/features/orders/domain/entity/order_entity.dart';
import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';
import 'package:rooh/features/orders/domain/entity/order_status.dart';
import 'package:rooh/features/orders/domain/entity/place_order_params.dart';
import 'package:rooh/features/orders/domain/entity/shipping_info_entity.dart';
import 'order_item_model.dart';
import 'shipping_info_model.dart';

abstract final class OrderFields {
  static const String createdAt = 'createdAt';
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
    required super.shippingInfo,
    required super.status,
    required super.createdAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    final rawCreatedAt = map[OrderFields.createdAt];

    return OrderModel(
      id: id,
      userId: map['userId'] as String,
      items: (map['items'] as List)
          .map(
            (e) => OrderItemModel.fromMap(Map<String, dynamic>.from(e as Map)),
          )
          .toList(),
      subtotal: (map['subtotal'] as num).toDouble(),
      deliveryFee: (map['deliveryFee'] as num).toDouble(),
      total: (map['total'] as num).toDouble(),
      shippingInfo: ShippingInfoModel.fromMap(
        Map<String, dynamic>.from(map['shipping'] as Map),
      ),
      status: _parseStatus(map['status']),
      createdAt: rawCreatedAt is Timestamp
          ? rawCreatedAt.toDate()
          : DateTime.now(),
    );
  }

  static Map<String, dynamic> toCreateMap(
    PlaceOrderParams params,
    String userId,
  ) {
    return {
      'userId': userId,
      'status': OrderStatus.pending.name,
      OrderFields.createdAt: FieldValue.serverTimestamp(),
      'items': params.items.map(_itemToMap).toList(),
      'subtotal': params.subtotal,
      'deliveryFee': params.deliveryFee,
      'total': params.total,
      'shipping': _shippingToMap(params.shippingInfo),
    };
  }

  static Map<String, dynamic> _itemToMap(OrderItemEntity item) {
    return {
      'productId': item.productId,
      'name': item.name,
      'unitPrice': item.unitPrice,
      'imgUrl': item.imgUrl,
      'quantity': item.quantity,
    };
  }

  static Map<String, dynamic> _shippingToMap(ShippingInfoEntity shipping) {
    return {
      'fullName': shipping.fullName,
      'phone': shipping.phone,
      'backupPhone': shipping.backupPhone,
      'governorate': shipping.governorate.name,
      'fullAddress': shipping.fullAddress,
    };
  }

  static OrderStatus _parseStatus(Object? raw) {
    return OrderStatus.values.asNameMap()[raw] ?? OrderStatus.pending;
  }
}
