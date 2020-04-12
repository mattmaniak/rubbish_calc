import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  /// Check if the user is signed in.
  Future<bool> get _isSignedIn async => await _currentUser != null;

  /// Try to fetch a current user.
  Future<FirebaseUser> get _currentUser async =>
      await _firebaseAuth.currentUser();

  /// Log into the Firebase.
  Future<String> signIn(String email, String password) async {
    if ((await _currentUser).isEmailVerified) {
      final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user.uid;
    } else {
      throw AuthException('', 'Unable to sign in. Verify your email.');
    }
  }

  /// Log in without providing any credentials.
  Future<String> signInAnonymously() async =>
      (await _firebaseAuth.signInAnonymously()).user.uid;

  /// Create an account.
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

  /// Say bye-bye to the Firebase safely.
  void signOut() async => await _firebaseAuth.signOut();

  /// Send an verification email to an active user.
  void verifyByEmail() async {
    try {
      (await _currentUser).sendEmailVerification();
    } on PlatformException {
      throw AuthException('',
          'Unable to send an verification email because this address is not connected with any account.');
    }
  }
}
