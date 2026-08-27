part of 'products_cubit.dart';

sealed class ProductsStates extends Equatable {
  const ProductsStates();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsStates {}

final class ProductsLoading extends ProductsStates {}

final class ProductsLoaded extends ProductsStates {
  final List<ProductsModel> allProducts;
  final List<ProductsModel> displayedProducts;

  const ProductsLoaded({
    required this.allProducts,
    required this.displayedProducts,
  });
  @override
  List<Object> get props => [allProducts, displayedProducts];
}

final class ProductsError extends ProductsStates {
  final String message;
  const ProductsError({required this.message});
  @override
  List<Object> get props => [message];
}
