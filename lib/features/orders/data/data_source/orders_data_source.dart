import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rooh/features/orders/domain/entity/place_order_params.dart';

import '../models/order_model.dart';

class OrdersDataSource {
  final FirebaseFirestore _firestore;
  const OrdersDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _ordersRef =>
      _firestore.collection('orders');

  String newOrderId() => _ordersRef.doc().id;

  Future<void> createOrder(String? uId, PlaceOrderParams params) {
    return _ordersRef
        .doc(params.orderId)
        .set(OrderModel.toCreateMap(params, uId));
  }

  Future<List<OrderModel>> getOrders(
    String uId, {
    required int limit,
    DateTime? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = _ordersRef
        .where(OrderFields.userId, isEqualTo: uId)
        .orderBy(OrderFields.createdAt, descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfter([Timestamp.fromDate(startAfter)]);
    }

    final snapShot = await query.get();
    final orders = <OrderModel>[];

    for (final doc in snapShot.docs) {
      try {
        orders.add(OrderModel.fromMap(doc.data(), doc.id));
      } catch (e) {
        debugPrint('⚠️ تخطي طلب تالف ${doc.id}: $e');
      }
    }
    return orders;
  }
}
