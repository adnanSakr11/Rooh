import 'package:equatable/equatable.dart';
import 'package:rooh/features/products/data/models/products_model.dart';

/// موديل عرض بس (Presentation) — مش Entity ومش جوه الـ Domain.
/// بيربط بين عنصر السلة (productId + quantity) وبيانات المنتج
/// الفعلية اللي بتتجاب لايف وقت العرض.
class CartItemView extends Equatable {
  final ProductsModel product;
  final int quantity;

  const CartItemView({required this.product, required this.quantity});

  double get subtotal => product.price * quantity;

  @override
  List<Object?> get props => [product, quantity];
}