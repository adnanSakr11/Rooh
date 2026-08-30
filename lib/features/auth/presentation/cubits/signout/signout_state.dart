part of 'signout_cubit.dart';

sealed class SignoutState extends Equatable {
  const SignoutState();

  @override
  List<Object> get props => [];
}

final class SignoutInitial extends SignoutState {}

final class SignOutSuccess extends SignoutState {}

final class SignoutLoading extends SignoutState {}

final class SignOutError extends SignoutState {
  final String message;
  const SignOutError({required this.message});

  @override
  List<Object> get props => [message];
}
