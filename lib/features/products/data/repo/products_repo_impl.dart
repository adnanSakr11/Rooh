import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/data/data_source/data_source.dart';
import 'package:rooh/features/products/data/data_source/products_data_source.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';
import '../data_source/products_seed_data.dart';
import '../model/products_model.dart';

class ProductRepositoryImpl extends ProductsRepo {
  final PexelsDataSource _pexelsDataSource = PexelsDataSource();
  final ProductsDataSource _productsData;
  ProductRepositoryImpl(this._productsData);

  static const String _fallbackImageUrl =
      'https://images.pexels.com/photos/3183150/pexels-photo-3183150.jpeg';

  @override
  Future<Either<Failure, List<ProductsEntity>>> fetchImagesOnPexels() async {
    try {
      final products = await Future.wait(
        seeds.map((seed) async {
          final imageUrl =
              await _pexelsDataSource.fetchImageUrl(seed.searchQuery) ??
              _fallbackImageUrl;

          return ProductsEntity(
            id: seed.id,
            name: seed.name,
            desc: seed.description,
            price: seed.price,
            imgUrl: imageUrl,
          );
        }),
      );

      return Right(products);
    } catch (e, st) {
      return left(
        Failure(
          message: 'فشل في تحميل البيانات حاول تاني',
          stackTrace: st,
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductsModel>>> fetchProductsData() async {
    try {
      final result = await _productsData.getAllProducts();

      return Right(result);
    } catch (e, st) {
      return Left(Failure(message: 'فشل في تحميل البيانات حاول تاني', cause: e, stackTrace: st));
    }
  }
}
