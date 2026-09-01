import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
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
    dynamic credential, {
    required String? phoneNumber,
  }) async {
    final firebaseUser = credential.user!;
    final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
    if (!isNewUser) {
      final existing = await _userDataSoruce.getUserProfile(firebaseUser.uid);
      if (existing != null) return existing;
    }
    final digits = firebaseUser.uid.replaceAll(RegExp(r'[^0-9]'), '');
    final last4 = digits.length >= 4
        ? digits.substring(digits.length - 4)
        : digits.padLeft(4, '0');
    final defaultName = firebaseUser.displayName ?? 'User$last4';

    final newUser = UserModel(
      phoneNumber,
      uId: firebaseUser.uid,
      userName: defaultName,
    );

    await _userDataSoruce.createUserProfile(newUser);
    return newUser;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _authDataSource.authStateChanges.asyncExpand((fbUser) {
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
      debugPrint('❌ signinWithGoogle real error: $e');
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
    } on Exception catch (e, st) {
      final code = _extractFirebaseCode(e);
      return Left(Failure(message: _mapAuthError(code), cause: e, stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserName(String newName) async {
    final uid = _authDataSource.currentUid;
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

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل تسجيل الخروج', cause: e, stackTrace: st),
      );
    }
  }

  String _extractFirebaseCode(Object e) {
    try {
      return (e as dynamic).code as String;
    } catch (_) {
      return '';
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
      case 'invalid-credential':
        return 'رقم الهاتف أو كلمة المرور غير صحيحة';
      case 'too-many-requests':
        return 'محاولات كتير، حاول لاحقًا';
      case 'network-request-failed':
        return 'مشكلة في الاتصال بالإنترنت';
      case 'user-disabled':
        return 'الحساب موقوف';
      default:
        return 'حدث خطأ، حاول مرة أخرى';
    }
  }
}