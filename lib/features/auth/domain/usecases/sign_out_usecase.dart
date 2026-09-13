import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class SignOutUsecase {
  final AuthRepo _authRepo;
  const SignOutUsecase(this._authRepo);
  Future<Either<Failure, void>> call() {
    return _authRepo.signOut();
  }
}
