import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooh/features/orders/data/models/order_item_model.dart';
import 'package:rooh/features/orders/data/models/shipping_info_model.dart';
import 'package:rooh/features/orders/domain/entity/order_entity.dart';
import 'package:rooh/features/orders/domain/entity/order_status.dart';
import '../../domain/entity/place_order_params.dart';

abstract class OrderFields {
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
            (e) =>
                OrderItemModel.fromMap(Map<String, dynamic>.from(e as Map), id),
          )
          .toList(),
      subtotal: map['subtotal'],
      deliveryFee: map['deliveryFee'],
      total: map['total'],
      shippingInfo: ShippingInfoModel.fromMap(
        Map<String, dynamic>.from(map['shippingInfo'] as Map),
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
      'items': params.items
          .map((i) => OrderItemModel.fromEntity(i).toMap())
          .toList(),
      'subtotal': params.subtotal,
      'deliveryFee': params.deliveryFee,
      'total': params.total,
      'shipping': ShippingInfoModel.fromEntity(params.shippingInfo).toMap(),
    };
  }

  static OrderStatus _parseStatus(Object? raw) {
    return OrderStatus.values.asNameMap()[raw] ?? OrderStatus.pending;
  }
}
