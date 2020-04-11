import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  void signOut() async => await _firebaseAuth.signOut();

  Future<FirebaseUser> get user async => await _firebaseAuth.currentUser();

  Future<bool> _isUserRegistered(FirebaseUser user) async =>
      user == null ? false : true;
}
