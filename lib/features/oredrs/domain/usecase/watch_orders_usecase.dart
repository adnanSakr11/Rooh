import 'package:rooh/features/oredrs/domain/entity/order_entity.dart';
import 'package:rooh/features/oredrs/domain/repo/orders_repo.dart';

class WatchOrdersUsecase {
  final OrdersRepo _ordersRepo;
  const WatchOrdersUsecase(this._ordersRepo);
  Stream<List<OrderEntity>> call() => _ordersRepo.watchOrders();
}
