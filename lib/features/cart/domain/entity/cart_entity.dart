import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final int quantity;
  const CartItemEntity({required this.productId, required this.quantity});

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(quantity: quantity ?? this.quantity, productId: productId);
  }

  @override
  List<Object?> get props => [productId, quantity];
}
