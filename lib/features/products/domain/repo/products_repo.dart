import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import '../../data/model/products_model.dart';
import '../entity/products_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductsEntity>>> fetchImagesOnPexels();
  Future<Either<Failure, List<ProductsModel>>> fetchProductsData();
}
