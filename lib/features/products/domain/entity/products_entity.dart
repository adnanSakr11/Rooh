import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String id;

  const ProductsEntity({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.id,
  });

  

  @override
  List<Object?> get props => [name, description, price, imageUrl, id];
}
