// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/features/products/domain/usecases/get_products_usecase.dart';
import 'package:rooh/features/products/domain/usecases/search_app_products.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit(this._getProducts, this._searchProducts)
    : super(ProductsInitial());
  final GetProductsUsecase _getProducts;
  final SearchAppProductsUsecase _searchProducts;

  Future<void> loadingProducts() async {
    emit(ProductsLoading());
    final result = await _getProducts();
    if (isClosed) return;
    result.fold(
      (f) => emit(ProductsError(message: f.message)),
      (r) => emit(ProductsLoaded(allProducts: r, displayedProducts: r)),
    );
  }

  void search(String query) {
    final currentState = state;
    if (currentState is! ProductsLoaded) {
      return;
    }

    if (query.isEmpty) {
      emit(
        ProductsLoaded(
          allProducts: currentState.allProducts,
          displayedProducts: currentState.allProducts,
        ),
      );
      return;
    }

    final result = _searchProducts(query, currentState.allProducts);
    result.fold(
      (l) => emit(ProductsError(message: l.message)),
      (r) => emit(
        ProductsLoaded(
          allProducts: currentState.allProducts,
          displayedProducts: r,
        ),
      ),
    );
  }
}
