import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooh/features/cart/domain/entity/cart_entity.dart';

class FirestoreCartDataSource {
  final FirebaseFirestore _firestore;
  const FirestoreCartDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> _cartRef(String uId) =>
      _firestore.collection('users').doc(uId).collection('cart');

  Stream<List<CartItemEntity>> watchCart(String uId) {
    return _cartRef(uId).snapshots().map((snapShot) {
      return snapShot.docs.map((doc) {
        final data = doc.data();
        return CartItemEntity(
          productId: doc.id,
          quantity: data['quantity'] as int,
        );
      }).toList();
    });
  }

  Future<void> addItemToCart(String uId, String productId) async {
    final docRef = _cartRef(uId).doc(productId);
    final doc = await docRef.get();
    if (doc.exists) {
      final currentQuantity = doc.data()?['quantity'] as int? ?? 0;
      await docRef.update({'quantity': currentQuantity + 1});
    } else {
      await docRef.set({'quantity': 1});
    }
  }

  Future<void> removeItemFromCart(String uId, String productId) async {
    return await _cartRef(uId).doc(productId).delete();
  }

  Future<void> updateCartQuantity(String uId, String productId, int quantity) {
    if (quantity <= 0) {
      return removeItemFromCart(uId, productId);
    } else {
      return _cartRef(uId).doc(productId).update({'quantity': quantity});
    }
  }

  Future<void> clearCart(String uId) async {
    final snapshot = await _cartRef(uId).get();
    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    return batch.commit();
  }
}
