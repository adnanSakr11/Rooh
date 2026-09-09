import 'package:rooh/features/products/domain/entity/products_entity.dart';

extension ProductsEntityExtensions on ProductsEntity {
  String get formattedPrice => 'جنيه ${price.toStringAsFixed(1)} ';
}
