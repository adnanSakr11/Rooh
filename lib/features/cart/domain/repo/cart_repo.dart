import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/domain/entity/cart_entity.dart';

abstract class CartRepo {
  Stream<List<CartItemEntity>> watchCart();
  Future<Either<Failure, void>> addItemToCart(String productId);
  Future<Either<Failure, void>> removeItemFromCart(String productId);
  Future<Either<Failure, void>> updateCartQuantity(
    String productId,
    int quantity,
  );
  Future<Either<Failure, void>> clearCart();
}
