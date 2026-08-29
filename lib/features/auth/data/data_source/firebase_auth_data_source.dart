import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthDataSource(this._firebaseAuth);
  Future<UserCredential> signinWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('تم إلغاء تسجيل الدخول');
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<UserCredential> signinWithPhoneAndPassword({
    required String phone,
    required String password,
  }) async {
    final String fakeEmail = '$phone@rooh.com';

    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: fakeEmail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return await _firebaseAuth.createUserWithEmailAndPassword(
          email: fakeEmail,
          password: password,
        );
      }
      rethrow;
    }
  }
}
