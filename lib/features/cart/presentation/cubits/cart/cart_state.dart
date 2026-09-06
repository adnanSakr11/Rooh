part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItemView> items;
  final double totalPrice;
  const CartLoaded({required this.items, required this.totalPrice});

  @override
  List<Object> get props => [items, totalPrice];
}

final class CartError extends CartState {
  final String message;
  const CartError({required this.message});
  @override
  List<Object> get props => [message];
}
