import 'package:rooh/features/auth/domain/entity/user_entity.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class WatchAuthStateUsecase {
  final AuthRepo _authRepo;
  WatchAuthStateUsecase({required this._authRepo});
  Stream<UserEntity?> call() => _authRepo.authStateChanges;
}
