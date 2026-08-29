import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class UpdateUserNameUsecase {
  final AuthRepo _authRepo;
  UpdateUserNameUsecase({required this._authRepo});
  Future<Either<Failure, void>> call({required String newName}) =>
      _authRepo.updateUserName(newName);
}
