import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import '../entity/order_entity.dart';
import '../repo/orders_repo.dart';

class GetOrdersUsecase {
  final OrdersRepo _ordersRepo;
  const GetOrdersUsecase(this._ordersRepo);

  Future<Either<Failure, List<OrderEntity>>> call({
    required int limit,
    DateTime? startAfter,
  }) => _ordersRepo.getOrders(limit: limit, startAfter: startAfter);
}