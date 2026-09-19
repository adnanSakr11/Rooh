import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/data/data_source/products_data_source.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';
import '../model/products_model.dart';

class ProductRepositoryImpl extends ProductsRepo {
  final ProductsDataSource _productsData;
  ProductRepositoryImpl(this._productsData);

  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts() async {
    try {
      final result = await _productsData.getAllProducts();

      return Right(result);
    } catch (e, st) {
      return Left(
        Failure(
          message: 'فشل في تحميل البيانات حاول تاني',
          cause: e,
          stackTrace: st,
        ),
      );
    }
  }
}
