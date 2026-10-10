part of 'checkout_cubit.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutSubmitting extends CheckoutState {}

final class CheckoutSuccess extends CheckoutState {
  final String orderId;
  const CheckoutSuccess({required this.orderId});
  @override
  List<Object> get props => [orderId];
}

final class CheckoutFailure extends CheckoutState {
  final String errorMessage;
  const CheckoutFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
