import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signinWithGoogle();
  Future<Either<Failure, UserEntity>> signinWithPhoneAndpass({
    required String phoneNumber,
    required String password,
  });
  Future<Either<Failure, void>> updateUserName(String newName);
  Stream<UserEntity?> get authStateChanges;
}
