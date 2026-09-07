import 'package:equatable/equatable.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';

class CartItemView extends Equatable {
  final ProductsEntity product;
  final int quantity;

  const CartItemView({required this.product, required this.quantity});

  double get subtotal => product.price * quantity;

  @override
  List<Object?> get props => [product, quantity];
}
