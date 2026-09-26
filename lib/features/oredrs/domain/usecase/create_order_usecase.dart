import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/oredrs/domain/entity/order_entity.dart';
import 'package:rooh/features/oredrs/domain/entity/shipping_info_entity.dart';
import 'package:rooh/features/oredrs/domain/repo/orders_repo.dart';

class CreateOrderUsecase {
  final OrdersRepo _ordersRepo;
  const CreateOrderUsecase({required this._ordersRepo});
  Future<Either<Failure, void>> call({
    required List<OrderEntity> orders,
    required double totalPrice,
    required ShippingInfoEntity shoppingInfo,
  }) => _ordersRepo.creatteOrders(
    orders: orders,
    totalPrice: totalPrice,
    shoppingInfo: shoppingInfo,
  );
}
