import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String id;

  const ProductsModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.id
  });

  String get formattedPrice => '${price.toStringAsFixed(0)} جنيه';

  @override
  List<Object?> get props => [name, description, price, imageUrl,id];
}
