import 'package:firebase_auth/firebase_auth.dart';
import 'package:toohak/_toohak.dart';

class MyAuthProvider {
  final FirebaseAuth _firebaseAuth = sl();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
