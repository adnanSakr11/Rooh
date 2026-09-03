import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/domain/repo/cart_repo.dart';

class UpdateCartQuantityUsecase {
  final CartRepo _cartRepo;
  const UpdateCartQuantityUsecase(this._cartRepo);
  Future<Either<Failure, void>> call(String productId, int quantity) =>
      _cartRepo.updateCartQuantity(productId, quantity);
}
 