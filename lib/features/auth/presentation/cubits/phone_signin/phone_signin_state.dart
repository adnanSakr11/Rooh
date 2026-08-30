part of 'phone_signin_cubit.dart';

sealed class PhoneSigninState extends Equatable {
  const PhoneSigninState();
  @override
  List<Object?> get props => [];
}

final class PhoneSigninInitial extends PhoneSigninState {}
final class PhoneSigninLoading extends PhoneSigninState {}
final class PhoneSigninSuccess extends PhoneSigninState {}
final class PhoneSigninError extends PhoneSigninState {
  final String message;
  const PhoneSigninError(this.message);
  @override
  List<Object?> get props => [message];
}