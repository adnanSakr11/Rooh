import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imgUrl;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, name, price, imgUrl, quantity];
}
