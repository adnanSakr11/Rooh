part of 'update_user_name_cubit.dart';

sealed class UpdateUserNameState extends Equatable {
  const UpdateUserNameState();

  @override
  List<Object> get props => [];
}

final class UpdateUserNameInitial extends UpdateUserNameState {}

final class UpdtaeUserNameSucced extends UpdateUserNameInitial {}

final class UpdateUserNameLoading extends UpdateUserNameInitial {}

final class UpdateUserNameError extends UpdateUserNameInitial {
  final String message;
  UpdateUserNameError({required this.message});
  @override
  List<Object> get props => [message];
}
