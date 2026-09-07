import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import '../entity/products_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductsEntity>>> fetchImagesOnPexels();
}
