import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/data/models/products_model.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';

class FetchImagesOnPexelsUsecase {
  final ProductsRepo _productsRepo;
  Future<Either<Failure, List<ProductsModel>>> call() => _productsRepo.fetchImagesOnPexels();
  FetchImagesOnPexelsUsecase(this._productsRepo);
}
