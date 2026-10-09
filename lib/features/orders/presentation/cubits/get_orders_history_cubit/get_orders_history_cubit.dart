import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:rooh/features/orders/domain/entity/order_entity.dart';
import 'package:rooh/features/orders/domain/usecases/get_orders_usecase.dart';

part 'get_orders_history_state.dart';

class OrdersHistoryCubit extends Cubit<OrdersHistoryState> {
  static const int pageSize = 20;
  final GetOrdersUsecase _getOrders;
  final AuthCubit _auth;
  late StreamSubscription<AuthState> _streamSubscription;
  String? _currentUid;
  int _generation = 0;

  OrdersHistoryCubit(this._getOrders, this._auth)
    : super(OrdersHistoryInitial()) {
    _handleAuth(_auth.state);
    _streamSubscription = _auth.stream.listen(_handleAuth);
  }

  void _handleAuth(AuthState auth) {
    if (auth is Authenticated) {
      if (auth.user.uId == _currentUid) return;
      _currentUid = auth.user.uId;
      loadingFirstPage();
    } else if (auth is Unauthenticated) {
      _currentUid = null;
      _generation++;
      emit(OrdersHistoryInitial());
    }
  }

  Future<void> loadingFirstPage() async {
    final generation = ++_generation;
    emit(OrdersHistoryLoading());
    final result = await _getOrders(limit: pageSize);
    if (isClosed || generation != _generation) return;

    result.fold(
      (f) => emit(OrdersHistoryError(errMessage: f.message)),
      (r) =>
          emit(OrdersHistoryLoaded(orders: r, hasMore: r.length == pageSize)),
    );
  }

  Future<Either<Failure, void>> refresh() async {
    if (_currentUid == null) return const Right(null);
    final generation = ++_generation;
    final result = await _getOrders(limit: pageSize);
    if (isClosed || generation != _generation) return const Right(null);
    return result.fold(
      (f) {
        if (state is! OrdersHistoryLoaded) {
          emit(OrdersHistoryError(errMessage: f.message));
        }
        return Left(f);
      },
      ((r) {
        emit(OrdersHistoryLoaded(orders: r, hasMore: r.length == pageSize));
        return const Right(null);
      }),
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! OrdersHistoryLoaded ||
        current.isLoadingMore ||
        !current.hasMore) {
      return;
    }
    final generation = _generation;
    emit(current.copyWith(isLoadingMore: true, loadMoreFailed: false));

    final result = await _getOrders(
      limit: pageSize,
      startAfter: current.orders.last.createdAt,
    );
    if (isClosed || generation != _generation) return;

    result.fold(
      (_) => emit(current.copyWith(isLoadingMore: false, loadMoreFailed: true)),
      (page) => emit(
        current.copyWith(
          orders: [...current.orders, ...page],
          hasMore: page.length == pageSize,
          isLoadingMore: false,
          loadMoreFailed: false
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
