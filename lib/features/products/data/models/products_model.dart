import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const ProductsModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  String get formattedPrice => '${price.toStringAsFixed(0)} جنيه';

  @override
  List<Object?> get props => [name, description, price, imageUrl];
}
