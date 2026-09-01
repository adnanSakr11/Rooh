import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSign;
  FirebaseAuthDataSource(this._firebaseAuth, this._googleSign);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String? get currentUid => _firebaseAuth.currentUser?.uid;

  Future<UserCredential> signinWithGoogle() async {
    final googleUser = await _googleSign.signIn();
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
      // في نسخ Firebase الحديثة، الأكواد الخاصة زي user-not-found
      // بقت متجمعة كلها تحت invalid-credential لأسباب أمنية، فمينفعش
      // نعتمد على الـ code وحده عشان نعرف الحساب مش موجود فعلاً ولا
      // الباسورد غلط بس. بنجرب ننشئ الحساب كـ fallback؛ لو فشل بـ
      // email-already-in-use يبقى الحساب موجود والمشكلة كانت باسورد غلط.
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        try {
          return await _firebaseAuth.createUserWithEmailAndPassword(
            email: fakeEmail,
            password: password,
          );
        } on FirebaseAuthException catch (createError) {
          if (createError.code == 'email-already-in-use') {
            throw FirebaseAuthException(
              code: 'wrong-password',
              message: 'كلمة المرور غير صحيحة',
            );
          }
          rethrow;
        }
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (await _googleSign.isSignedIn()) {
      await _googleSign.signOut();
      await _googleSign.disconnect();
    }
  }
}
