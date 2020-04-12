import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<bool> get _isSignedIn async =>
      await _firebaseAuth.currentUser() != null;

  Future<FirebaseUser> get _currentUser async =>
      await _firebaseAuth.currentUser();

  Future<String> signIn(String email, String password) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  Future<String> signInAnonymously() async {
    final AuthResult result = await _firebaseAuth.signInAnonymously();
    return result.user.uid;
  }

  void signOut() async => await _firebaseAuth.signOut();

  Future<String> signUp(String email, String password) async {
    try {
      final AuthResult result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user.uid;
    } on PlatformException {
      throw AuthException('', 'This email is already in use.');
    }
  }

  void verifyByEmail() async {
    final FirebaseUser user = await _currentUser;
    if (await _isSignedIn) {
      try {
        user.sendEmailVerification();
      } on PlatformException {
        throw AuthException(
            '', 'Unable to verify this account. Email is not registered.');
      }
    }
  }
}
