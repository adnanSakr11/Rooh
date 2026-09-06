part of 'google_signin_cubit.dart';

sealed class GoogleSigninState extends Equatable {
  const GoogleSigninState();

  @override
  List<Object> get props => [];
}

final class GoogleSigninInitial extends GoogleSigninState {}

final class GoogleSiginSucces extends GoogleSigninState {}

final class GoogleSiginLoading extends GoogleSigninState {}

final class GoogleSiginError extends GoogleSigninState {
  final String message;
  const GoogleSiginError({required this.message});
  @override
  List<Object> get props => [message];
}
