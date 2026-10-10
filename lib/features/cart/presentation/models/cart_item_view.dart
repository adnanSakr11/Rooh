import 'package:equatable/equatable.dart';
import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';

class CartItemView extends Equatable {
  final ProductsEntity product;
  final int quantity;

  const CartItemView({required this.product, required this.quantity});

  double get subtotal => product.price * quantity;

  OrderItemEntity toOrderItem() => OrderItemEntity(
    productId: product.id,
    name: product.name,
    unitPrice: product.price,
    imgUrl: product.imgUrl,
    quantity: quantity,
  );

  @override
  List<Object?> get props => [product, quantity];
}