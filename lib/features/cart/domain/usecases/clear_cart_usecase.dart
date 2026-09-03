import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/domain/repo/cart_repo.dart';

class ClearCartUsecase {
  final CartRepo _cartRepo;
  const ClearCartUsecase(this._cartRepo);
  Future<Either<Failure, void>> call() => _cartRepo.clearCart();
}
