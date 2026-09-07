import 'package:equatable/equatable.dart';

class ProductSeedEntity extends Equatable {
  final String name;
  final String description;
  final String id;
  final double price;
  final String searchQuery;

  const ProductSeedEntity({
    required this.name,
    required this.description,
    required this.price,
    required this.searchQuery,
    required this.id,
  });

  @override
  List<Object?> get props => [name, description, price, searchQuery, id];
}
