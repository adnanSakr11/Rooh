import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/data/data_source/data_source.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';
import '../data_source/products_seed_data.dart';

class ProductRepositoryImpl extends ProductsRepo {
  final PexelsDataSource _pexelsDataSource = PexelsDataSource();

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
            name: seed.name,
            description: seed.description,
            price: seed.price,
            imageUrl: imageUrl,
            id: seed.id,
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
}
