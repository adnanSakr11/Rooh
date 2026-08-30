import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class SignOutUsecasse {
  final AuthRepo _authRepo;
  const SignOutUsecasse(this._authRepo);
  Future<Either<Failure, void>> call() {
    return _authRepo.signOut();
  }
}
