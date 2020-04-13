import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  /// Firebase handler.
  final _firebaseAuth = FirebaseAuth.instance;

  /// Try to get a currently signed in user.
  Future<FirebaseUser> get currentUser async =>
      await _firebaseAuth.currentUser();

  /// Check if the user is signed in.
  Future<bool> get _isSignedIn async => await currentUser != null;

  /// Log into the Firebase.
  Future<String> signIn(String email, String password) async {
    try {
      final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!(await currentUser).isEmailVerified) {
        throw AuthException('',
            'Unable to sign in. Check your mailbox and verify your account.');
      }
      return result.user.uid;
    } on AuthException {
      rethrow;
    } on PlatformException {
      throw AuthException(
          '', 'Unable to sign in. User with given credentials not found.');
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

  /// Say bye-bye to the Firebase safely and clear the disk cache.
  Future<void> signOut() async => await _firebaseAuth.signOut();

  /// Send an verification email to an active user.
  Future<void> verifyByEmail() async {
    if (await _isSignedIn) {
      try {
        (await currentUser).sendEmailVerification();
      } on PlatformException {
        throw AuthException('',
            'Unable to send a verification email because this address is not connected with any account.');
      }
    }
  }
}
