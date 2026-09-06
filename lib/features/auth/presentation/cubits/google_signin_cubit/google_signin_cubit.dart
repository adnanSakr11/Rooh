import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/features/auth/domain/usecases/signin_with_google.dart';

part 'google_signin_state.dart';

class GoogleSigninCubit extends Cubit<GoogleSigninState> {
  final SigninWithGoogleUsecase _googleUsecase;
  GoogleSigninCubit(this._googleUsecase) : super(GoogleSigninInitial());
  Future<void> googleSignin() async {
    emit(GoogleSiginLoading());

    final result = await _googleUsecase();
    result.fold(
      (f) => emit(GoogleSiginError(message: f.message)),
      (_) => emit(GoogleSiginSucces()),
    );
  }
}
