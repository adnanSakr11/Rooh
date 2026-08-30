import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/features/auth/domain/usecases/signin_with_phone_and_pass.dart';

part 'phone_signin_state.dart';

class PhoneSigninCubit extends Cubit<PhoneSigninState> {
  final SigninWithPhoneAndPassUsecase _phoneAndPassUsecase;
  PhoneSigninCubit(this._phoneAndPassUsecase) : super(PhoneSigninInitial());

  Future<void> phoneSignin(String phone, String password) async {
    emit(PhoneSigninLoading());
    final result = await _phoneAndPassUsecase(
      phoneNumber: phone,
      password: password,
    );

    result.fold(
      (f) => emit(PhoneSigninError(f.message)),
      (_) => emit(PhoneSigninSuccess()),
    );
  }
}
