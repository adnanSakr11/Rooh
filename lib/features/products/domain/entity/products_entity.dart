import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final String id;
  final String name;
  final String desc;
  final double price;
  final String imgUrl;

  const ProductsEntity({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.imgUrl,
  });

  @override
  List<Object?> get props => [name, desc, price, imgUrl, id];
}
