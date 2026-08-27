import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import '../../data/models/products_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductsModel>>> fetchImagesOnPexels();
}
