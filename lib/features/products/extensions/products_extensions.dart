import 'package:rooh/core/utils/money.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';

extension ProductsEntityExtensions on ProductsEntity {
  String get formattedPrice => price.asEgp;
}