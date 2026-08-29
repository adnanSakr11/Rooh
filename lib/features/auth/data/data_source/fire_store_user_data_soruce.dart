import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rooh/features/auth/data/models/user_model.dart';

class FireStoreUserDataSoruce {
  final FirebaseFirestore _firestore;
  FireStoreUserDataSoruce(this._firestore);
  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection('users');

  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }

  Future<void> createUserProfile(UserModel user) async {
    return await _usersRef.doc(user.uId).set(user.toMap());
  }

  Future<void> updateUserName(String uid, String newName) async {
    return await _usersRef.doc(uid).update({'name': newName});
  }

  Stream<UserModel?> streamUserProfile(String uid) {
    return _usersRef.doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromMap(doc.data()!);
    });
  }
}
