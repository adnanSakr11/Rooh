part of 'create_orders_cubit.dart';

sealed class CreateOrdersState extends Equatable {
  const CreateOrdersState();

  @override
  List<Object> get props => [];
}

final class CreateOrdersInitial extends CreateOrdersState {}
