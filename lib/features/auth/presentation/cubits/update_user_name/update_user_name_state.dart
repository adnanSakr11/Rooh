part of 'update_user_name_cubit.dart';

sealed class UpdateUserNameState extends Equatable {
  const UpdateUserNameState();

  @override
  List<Object> get props => [];
}

final class UpdateUserNameInitial extends UpdateUserNameState {}

final class UpdateUserNameLoading extends UpdateUserNameState {}

final class UpdtaeUserNameSucced extends UpdateUserNameState {}

final class UpdateUserNameError extends UpdateUserNameState {
  final String message;
  const UpdateUserNameError({required this.message});
  @override
  List<Object> get props => [message];
}