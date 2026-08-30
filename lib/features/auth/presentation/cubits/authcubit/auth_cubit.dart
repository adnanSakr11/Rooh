import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rooh/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import '../../../domain/entity/user_entity.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final WatchAuthStateUsecase _watchAuthState;
  late final StreamSubscription<UserEntity?> _authSubscription;

  AuthCubit(this._watchAuthState) : super(AuthInitial()) {
    _authSubscription = _watchAuthState().listen((user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
