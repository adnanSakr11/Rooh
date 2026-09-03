import 'package:rooh/features/cart/domain/entity/cart_entity.dart';
import 'package:rooh/features/cart/domain/repo/cart_repo.dart';

class WatchCartUsecase {
  final CartRepo _cartRepo;
  const WatchCartUsecase(this._cartRepo);
  Stream<List<CartItemEntity>> call() => _cartRepo.watchCart();
}
