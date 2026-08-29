import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/domain/entity/user_entity.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class SigninWithGoogleUsecase {
  final AuthRepo _authRepo;
  SigninWithGoogleUsecase({required this._authRepo});
  Future<Either<Failure, UserEntity>> call() => _authRepo.signinWithGoogle();
}
