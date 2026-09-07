import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:rooh/features/cart/domain/entity/cart_entity.dart';
import 'package:rooh/features/cart/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:rooh/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:rooh/features/cart/domain/usecases/remove_item_from_cart.dart';
import 'package:rooh/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:rooh/features/cart/domain/usecases/watch_cart_usecase.dart';
import 'package:rooh/features/products/domain/entity/products_entity.dart';
import 'package:rooh/features/products/domain/usecases/fetch_images_on_pexels_usecase.dart';
import '../../models/cart_item_view.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final WatchCartUsecase _watchCart;
  final AddItemToCartUsecase _addItem;
  final RemoveItemFromCartUsecase _removeItem;
  final UpdateCartQuantityUsecase _updateQuantity;
  final ClearCartUsecase _clearCart;
  final FetchImagesOnPexelsUsecase _fetchProducts;
  final AuthCubit _authCubit;

  StreamSubscription<List<CartItemEntity>>? _cartSubscription;
  StreamSubscription<AuthState>? _authSubscription;
  List<ProductsEntity> _products = [];

  CartCubit(
    this._watchCart,
    this._addItem,
    this._removeItem,
    this._updateQuantity,
    this._clearCart,
    this._fetchProducts,
    this._authCubit,
  ) : super(CartInitial()) {
    _loadProductsThenWatchCart();

    _authSubscription = _authCubit.stream.listen((_) {
      _resubscribeToCart();
    });
  }

  Future<void> _loadProductsThenWatchCart() async {
    emit(CartLoading());
    final result = await _fetchProducts();
    if (isClosed) return;
    result.fold((f) => emit(CartError(message: f.message)), (products) {
      _products = products;
      _resubscribeToCart();
    });
  }

  void _resubscribeToCart() {
    _cartSubscription?.cancel();
    _cartSubscription = _watchCart().listen((items) {
      if (isClosed) return;
      _emitLoaded(items);
    });
  }

  void _emitLoaded(List<CartItemEntity> items) {
    if (isClosed) return;

    final views = <CartItemView>[];

    for (final item in items) {
      final product = _findProduct(item.productId);
      if (product != null) {
        views.add(CartItemView(product: product, quantity: item.quantity));
      }
    }

    final total = views.fold<double>(0, (sum, v) => sum + v.subtotal);
    emit(CartLoaded(items: views, totalPrice: total));
  }

  ProductsEntity? _findProduct(String id) {
    for (final p in _products) {
      if (p.id == id) return p;
    }
    return null;
  }

  Future<Either<Failure, void>> addToCart(String productId) =>
      _addItem(productId);

  Future<Either<Failure, void>> removeFromCart(String productId) =>
      _removeItem(productId);

  Future<Either<Failure, void>> updateQuantity(
    String productId,
    int quantity,
  ) => _updateQuantity(productId, quantity);

  Future<Either<Failure, void>> clearCart() => _clearCart();

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
