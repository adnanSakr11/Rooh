import 'dart:async';

import 'package:rooh/features/cart/domain/entity/cart_entity.dart';

class LocalCartDataSource {
  final List<CartItemEntity> _items = [];
  final _controller = StreamController<List<CartItemEntity>>.broadcast();

  Stream<List<CartItemEntity>> watchCart() {
    Future.microtask(() => _controller.add(List.unmodifiable(_items)));
    return _controller.stream;
  }

  void addItemToCart(String productId) {
    final index = _items.indexWhere((i) => i.productId == productId);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItemEntity(productId: productId, quantity: 1));
    }
    _emit();
  }

  void removeItemFromCart(String productId) {
    _items.removeWhere((i) => i.productId == productId);
    _emit();
  }

  void updateCartQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItemFromCart(productId);
      return;
    }

    final index = _items.indexWhere((i) => i.productId == productId);

    if (index == -1) return;

    _items[index] = _items[index].copyWith(quantity: quantity);
    _emit();
  }

  void clearCart() {
    _items.clear();
    _emit();
  }

  void _emit() => _controller.add(List.unmodifiable(_items));
  void dispose() => _controller.close();
}
