import '../repo/orders_repo.dart';

class GenerateOrderIdUsecase {
  final OrdersRepo _ordersRepo;
  const GenerateOrderIdUsecase(this._ordersRepo);

  String call() => _ordersRepo.newOrderId();
}