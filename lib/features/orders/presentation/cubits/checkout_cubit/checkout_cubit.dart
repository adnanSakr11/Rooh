import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';
import 'package:rooh/features/orders/domain/entity/place_order_params.dart';
import 'package:rooh/features/orders/domain/entity/shipping_info_entity.dart';
import 'package:rooh/features/orders/domain/usecases/generate_order_id_usecase.dart';
import '../../../domain/usecases/create_orders_usecase.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateOrderUsecase _createOrder;
  final ClearCartUsecase _clearCart;
  final List<OrderItemEntity> _items;
  final String _orderId;

  CheckoutCubit(
    this._createOrder,
    this._clearCart,
    GenerateOrderIdUsecase generateOrderId,
    this._items,
  ) : _orderId = generateOrderId(),
      super(CheckoutInitial());

  Future<void> submit(ShippingInfoEntity shippingInfo) async {
    if (state is CheckoutSubmitting || state is CheckoutSuccess) return;
    emit(CheckoutSubmitting());

    final result = await _createOrder(
      PlaceOrderParams(
        orderId: _orderId,
        items: _items,
        shippingInfo: shippingInfo,
      ),
    );

    final failure = result.fold<Failure?>((f) => f, (_) => null);
    if (failure != null) {
      if (!isClosed) emit(CheckoutFailure(errorMessage: failure.message));
      return;
    }

    await _clearCart();
    if (!isClosed) emit(CheckoutSuccess(orderId: _orderId));
  }
}