part of 'get_orders_history_cubit.dart';

sealed class OrdersHistoryState extends Equatable {
  const OrdersHistoryState();

  @override
  List<Object> get props => [];
}

final class OrdersHistoryInitial extends OrdersHistoryState {}

final class OrdersHistoryLoading extends OrdersHistoryState {}

final class OrdersHistoryLoaded extends OrdersHistoryState {
  final List<OrderEntity> orders;
  final bool hasMore;
  final bool isLoadingMore;
  final bool loadMoreFailed;

  const OrdersHistoryLoaded({
    required this.orders,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });
  OrdersHistoryLoaded copyWith({
    List<OrderEntity>? orders,
    bool? hasMore,
    bool? isLoadingMore,
    bool? loadMoreFailed,
  }) {
    return OrdersHistoryLoaded(
      orders: orders ?? this.orders,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
    );
  }

  @override
  List<Object> get props => [orders, hasMore, isLoadingMore, loadMoreFailed];
}

final class OrdersHistoryError extends OrdersHistoryState {
  final String errMessage;
  const OrdersHistoryError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
