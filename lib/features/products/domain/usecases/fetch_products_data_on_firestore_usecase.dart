import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';

class FetchProductsDataOnFirestoreUsecase {
  final ProductsRepo _productsRepo;
  const FetchProductsDataOnFirestoreUsecase(this._productsRepo);

  Future<Either<Failure, void>> call() => _productsRepo.fetchProductsData();
}
