part of 'google_signin_cubit.dart';

sealed class GoogleSigninState extends Equatable {
  const GoogleSigninState();

  @override
  List<Object> get props => [];
}

final class GoogleSigninInitial extends GoogleSigninState {}

final class GoolgeSiginSucces extends GoogleSigninState {}

final class GoolgeSiginLoading extends GoogleSigninState {}

final class GoolgeSiginError extends GoogleSigninState {
  final String message;
  const GoolgeSiginError({required this.message});
  @override
  List<Object> get props => [message];
}
