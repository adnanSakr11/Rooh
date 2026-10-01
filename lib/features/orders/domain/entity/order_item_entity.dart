import 'package:equatable/equatable.dart';
import 'package:rooh/core/utils/money.dart';

class OrderItemEntity extends Equatable {
  final String productId;
  final String name;
  final double unitPrice;
  final String imgUrl;
  final int quantity;

  const OrderItemEntity({
    required this.productId,
    required this.name,
    required this.unitPrice,
    required this.imgUrl,
    required this.quantity,
  });

  double get subtotal => roundMoney(unitPrice * quantity);

  @override
  List<Object?> get props => [productId, name, unitPrice, imgUrl, quantity];
}