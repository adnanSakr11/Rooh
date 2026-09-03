import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/domain/repo/cart_repo.dart';

class AddItemToCartUsecase {
  final CartRepo _cartRepo;
  const AddItemToCartUsecase(this._cartRepo);
  Future<Either<Failure, void>> call(String productId) =>
      _cartRepo.addItemToCart(productId);
}
