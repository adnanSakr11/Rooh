import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/features/auth/domain/usecases/update_user_name.dart';

part 'update_user_name_state.dart';

class UpdateUserNameCubit extends Cubit<UpdateUserNameState> {
  final UpdateUserNameUsecase _userNameUsecase;
  UpdateUserNameCubit(this._userNameUsecase) : super(UpdateUserNameInitial());

  Future<void> updateUserName(String newName) async {
    emit(UpdateUserNameLoading());
    final result = await _userNameUsecase(newName: newName);
    result.fold(
      (f) => emit(UpdateUserNameError(message: f.message)),
      (_) => emit(UpdtaeUserNameSucced()),
    );
  }
}
