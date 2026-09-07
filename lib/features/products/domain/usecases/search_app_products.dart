import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';

import '../entity/products_entity.dart';

class SearchAppProductsUsecase {
  Either<Failure, List<ProductsEntity>> call(
    String query,
    List<ProductsEntity> products,
  ) {
    final results = products
        .where((p) => p.name.contains(query))
        .take(20)
        .toList();
    return Right(results);
  }
}
