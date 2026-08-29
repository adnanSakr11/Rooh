import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/data/data_source/fire_store_user_data_soruce.dart';
import 'package:rooh/features/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:rooh/features/auth/data/models/user_model.dart';
import 'package:rooh/features/auth/domain/entity/user_entity.dart';
import 'package:rooh/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FireStoreUserDataSoruce _userDataSoruce;
  final FirebaseAuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource, this._userDataSoruce);

  Future<UserModel> _ensureUserProfile(
    fb.UserCredential credential, {
    required String? phoneNumber,
  }) async {
    final firebaseUser = credential.user!;
    final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
    if (!isNewUser) {
      final existing = await _userDataSoruce.getUserProfile(firebaseUser.uid);
      if (existing != null) return existing;
    }
    final defaultName =
        firebaseUser.displayName ??
        'User${firebaseUser.uid.replaceAll(RegExp(r'[^0-9]'), '').padLeft(4, '0').substring((firebaseUser.uid.replaceAll(RegExp(r'[^0-9]'), '').length >= 4) ? firebaseUser.uid.replaceAll(RegExp(r'[^0-9]'), '').length - 4 : 0)}';

    final newUser = UserModel(
      phoneNumber!,
      uId: firebaseUser.uid,
      userName: defaultName,
    );

    await _userDataSoruce.createUserProfile(newUser);
    return newUser;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return fb.FirebaseAuth.instance.authStateChanges().asyncExpand((fbUser) {
      if (fbUser == null) return Stream.value(null);
      return _userDataSoruce.streamUserProfile(fbUser.uid);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    try {
      final credential = await _authDataSource.signinWithGoogle();
      final user = await _ensureUserProfile(credential, phoneNumber: null);
      return Right(user);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل تسجيل الدخول بجوجل', stackTrace: st, cause: e),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithPhoneAndpass({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final credential = await _authDataSource.signinWithPhoneAndPassword(
        phone: phoneNumber,
        password: password,
      );
      final user = await _ensureUserProfile(
        credential,
        phoneNumber: phoneNumber,
      );
      return Right(user);
    } on fb.FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapAuthError(e.code)));
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل تسجيل الدخول', cause: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateUserName(String newName) async {
    final uid = fb.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Left(Failure(message: 'يجب تسجيل الدخول أولاً'));
    }
    try {
      await _userDataSoruce.updateUserName(uid, newName);
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل تحديث الاسم', cause: e, stackTrace: st),
      );
    }
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'invalid-email':
        return 'رقم الهاتف غير صالح';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جدًا';
      default:
        return 'حدث خطأ، حاول مرة أخرى';
    }
  }
}
