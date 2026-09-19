import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';

class GetProductsUsecase {
  final ProductsRepo _productsRepo;
  const GetProductsUsecase(this._productsRepo);

  Future<Either<Failure, List<ProductsEntity>>> call() =>
      _productsRepo.getProducts();
}
