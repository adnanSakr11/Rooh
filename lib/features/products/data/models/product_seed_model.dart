import 'package:equatable/equatable.dart';

class ProductSeedModel extends Equatable {
  final String name;
  final String description;
  final double price;
  final String searchQuery;

  const ProductSeedModel({
    required this.name,
    required this.description,
    required this.price,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [
    name,description,price,searchQuery
  ];
}
