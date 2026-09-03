import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/features/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:rooh/features/cart/data/data_source/firestore_cart_data_source.dart';
import 'package:rooh/features/cart/data/data_source/local_cart_data_source.dart';
import 'package:rooh/features/cart/domain/entity/cart_entity.dart';
import 'package:rooh/features/cart/domain/repo/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final FirestoreCartDataSource _firestoreCartDataSource;
  final LocalCartDataSource _localCartDataSource;
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  CartRepoImpl(
    this._localCartDataSource,
    this._firestoreCartDataSource,
    this._firebaseAuthDataSource,
  );
  @override
  Future<Either<Failure, void>> addItemToCart(String productId) async {
    try {
      final uId = _firebaseAuthDataSource.currentUid;
      if (uId == null) {
        _localCartDataSource.addItemToCart(productId);
      } else {
        await _firestoreCartDataSource.addItemToCart(uId, productId);
      }
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل إضافة المنتج للسلة', cause: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      final uId = _firebaseAuthDataSource.currentUid;
      if (uId == null) {
        _localCartDataSource.clearCart();
      } else {
        await _firestoreCartDataSource.clearCart(uId);
      }
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل تفريغ السلة', cause: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeItemFromCart(String productId) async {
    try {
      final uId = _firebaseAuthDataSource.currentUid;
      if (uId == null) {
        _localCartDataSource.removeItemFromCart(productId);
      } else {
        await _firestoreCartDataSource.removeItemFromCart(uId, productId);
      }
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل حذف المنتج من السلة', cause: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateCartQuantity(
    String productId,
    int quantity,
  ) async {
    try {
      final uId = _firebaseAuthDataSource.currentUid;
      if (uId == null) {
        _localCartDataSource.updateCartQuantity(productId, quantity);
      } else {
        await _firestoreCartDataSource.updateCartQuantity(
          uId,
          productId,
          quantity,
        );
      }
      return Right(null);
    } catch (e, st) {
      return Left(
        Failure(message: 'فشل تحديث الكمية', cause: e, stackTrace: st),
      );
    }
  }

  @override
  Stream<List<CartItemEntity>> watchCart() {
    final uId = _firebaseAuthDataSource.currentUid;
    if (uId == null) {
      return _localCartDataSource.watchCart();
    } else {
      return _firestoreCartDataSource.watchCart(uId);
    }
  }
}
