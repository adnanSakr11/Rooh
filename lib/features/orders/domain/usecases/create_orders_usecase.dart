import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import '../entity/place_order_params.dart';
import '../repo/orders_repo.dart';

class CreateOrderUsecase {
  final OrdersRepo _ordersRepo;
  const CreateOrderUsecase(this._ordersRepo);

  Future<Either<Failure, void>> call(PlaceOrderParams params) async {
    if (params.items.isEmpty) {
      return const Left(Failure(message: 'السلة فاضية'));
    }
    final hasInvalidItem = params.items.any(
      (i) => i.quantity <= 0 || i.unitPrice < 0,
    );
    if (hasInvalidItem) {
      return const Left(Failure(message: 'بيانات الطلب غير صالحة'));
    }
    return _ordersRepo.createOrder(params);
  }
}