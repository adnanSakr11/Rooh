import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import '../entity/order_entity.dart';
import '../entity/place_order_params.dart';

abstract class OrdersRepo {
  String newOrderId();

  Future<Either<Failure, void>> createOrder(PlaceOrderParams params);

  Future<Either<Failure, List<OrderEntity>>> getOrders({
    required int limit,
    DateTime? startAfter,
  });
}