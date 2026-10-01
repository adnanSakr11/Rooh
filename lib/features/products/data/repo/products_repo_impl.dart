import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/products/data/data_source/products_data_source.dart';
import 'package:rooh/features/products/domain/repo/products_repo.dart';
import '../model/products_model.dart';

class ProductRepositoryImpl extends ProductsRepo {
  final ProductsDataSource _productsData;
  ProductRepositoryImpl(this._productsData);

  List<ProductsModel>? _cache;
  Future<Either<Failure, List<ProductsModel>>>? _inFlight;

  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts({
    bool forceRefresh = false,
  }) {
    final cached = _cache;
    if (!forceRefresh && cached != null) return Future.value(Right(cached));
    return _inFlight ??= _fetch().whenComplete(() => _inFlight = null);
  }

  Future<Either<Failure, List<ProductsModel>>> _fetch() async {
    try {
      final result = await _productsData.getAllProducts();
      _cache = result;
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
