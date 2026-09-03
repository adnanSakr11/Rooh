import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/domain/repo/cart_repo.dart';

class RemoveItemFromCartUsecase {
  final CartRepo _cartRepo;
  const RemoveItemFromCartUsecase(this._cartRepo);
  Future<Either<Failure, void>> call(String productId) =>
      _cartRepo.removeItemFromCart(productId);
}
