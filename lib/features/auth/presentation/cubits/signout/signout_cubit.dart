import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/features/auth/domain/usecases/sign_out_usecasse.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  final SignOutUsecasse _signOutUsecasse;
  SignoutCubit(this._signOutUsecasse) : super(SignoutInitial());

  Future<void> signOut() async {
    emit(SignoutLoading());
    final result = await _signOutUsecasse.call();
    result.fold(
      (l) => emit(SignOutError(message: l.message)),
      (r) => emit(SignOutSuccess()),
    );
  }
}
