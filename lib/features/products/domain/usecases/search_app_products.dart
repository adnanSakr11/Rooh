import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';

import '../../data/models/products_model.dart';

class SearchAppProductsUsecase {
  Either<Failure, List<ProductsModel>> call(
    String query,
    List<ProductsModel> products,
  ) {
    final results = products
        .where((p) => p.name.contains(query))
        .take(20)
        .toList();
    return Right(results);
  }
}
