import 'package:dartz/dartz.dart';
import 'package:rooh/core/errors/failure.dart';
import 'package:rooh/core/errors/order_map_error.dart';
import 'package:rooh/features/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:rooh/features/orders/data/data_source/orders_data_source.dart';
import 'package:rooh/features/orders/domain/entity/order_entity.dart';
import 'package:rooh/features/orders/domain/entity/place_order_params.dart';
import 'package:rooh/features/orders/domain/repo/orders_repo.dart';

class OrdersRepoImpl extends OrdersRepo {
  final OrdersDataSource _ordersDataSource;
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  OrdersRepoImpl(this._ordersDataSource, this._firebaseAuthDataSource);

  static const Duration _writeTimeout = Duration(seconds: 15);

  static const String _notLoggedInMessage = 'يجب تسجيل الدخول أولاً';

  @override
  Future<Either<Failure, void>> createOrder(PlaceOrderParams params) async {
    final uId = _firebaseAuthDataSource.currentUid;

    try {
      await _ordersDataSource.createOrder(uId, params).timeout(_writeTimeout);
      return const Right(null);
    } catch (e, st) {
      return Left(
        Failure(
          message: orderMapError(e, fallback: 'فشل إرسال الطلب، حاول مرة أخرى'),
          cause: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({
    required int limit,
    DateTime? startAfter,
  }) async {
    final uId = _firebaseAuthDataSource.currentUid;
    if (uId == null) return const Left(Failure(message: _notLoggedInMessage));

    try {
      final orders = await _ordersDataSource.getOrders(
        uId,
        limit: limit,
        startAfter: startAfter,
      );
      return Right(orders);
    } catch (e, st) {
      return Left(
        Failure(
          message: orderMapError(
            e,
            fallback: 'فشل تحميل الطلبات، حاول مرة أخرى',
          ),
          cause: e,
          stackTrace: st,
        ),
      );
    }
  }

  @override
  String newOrderId() => _ordersDataSource.newOrderId();
}