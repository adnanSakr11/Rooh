import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/domain/entity/user_entity.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class SigninWithPhoneAndPassUsecase {
  final AuthRepo _authRepo;
  SigninWithPhoneAndPassUsecase({required this._authRepo});
  Future<Either<Failure, UserEntity>> call({
    required String phoneNumber,
    required String password,
  }) => _authRepo.signinWithPhoneAndpass(
    phoneNumber: phoneNumber,
    password: password,
  );
}
