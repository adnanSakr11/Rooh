import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/oredrs/domain/entity/order_entity.dart';
import 'package:rooh/features/oredrs/domain/entity/shipping_info_entity.dart';

abstract class OrdersRepo {
  Stream<List<OrderEntity>> watchOrders();
  Future<Either<Failure, void>> creatteOrders({
    required List<OrderEntity> orders,
    required double totalPrice,
    required ShippingInfoEntity shoppingInfo,
  });
}
