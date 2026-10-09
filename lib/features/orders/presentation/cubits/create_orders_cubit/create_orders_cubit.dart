import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_orders_state.dart';

class CreateOrdersCubit extends Cubit<CreateOrdersState> {
  CreateOrdersCubit() : super(CreateOrdersInitial());
}
