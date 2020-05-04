part of 'firebase.dart';

/// Provide Firebase Authentication mechanism.
class Auth {
  /// Firebase handler.
  final _firebaseAuth = FirebaseAuth.instance;

  /// Try to get a currently logged user.
  Future<FirebaseUser> get currentUser async =>
      await _firebaseAuth.currentUser();

  /// Check if an user's email is verified an is able to log into an account.
  Future<bool> get _isEmailVerified async =>
      await _isUserSignedIn && (await currentUser).isEmailVerified;

  /// Check if the user is signed in.
  Future<bool> get _isUserSignedIn async => await currentUser != null;

  /// Log into the Firebase.
  Future<String> signIn(String email, String password) async {
    try {
      final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!await _isEmailVerified) {
        throw PlatformException(
          code: 'ERROR_EMAIL_NOT_VERIFIED',
        );
      }
      return result.user?.uid;
    } on PlatformException {
      rethrow;
    }
  }

  /// Log in without providing any credentials.
  Future<String> signInAnonymously() async =>
      (await _firebaseAuth.signInAnonymously()).user?.uid;

  /// Create an account.
  Future<String> signUp(String email, String password) async {
    try {
      final AuthResult result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _verifyEmail();
      return result.user?.uid;
    } on PlatformException {
      rethrow;
    }
  }

  /// Log out and remove a currently logged in user.
  Future<void> deleteAccount() async {
    if (await _isUserSignedIn) {
      (await currentUser).delete();
    }
  }

  /// Send a link to an email to reset an user's password.
  Future<void> resetPassword() async =>
      (await _firebaseAuth.sendPasswordResetEmail(
        email: (await currentUser).email,
      ));

  /// Say bye-bye to the Firebase safely and clear the disk cache.
  Future<void> signOut() async {
    if (await _isUserSignedIn) {
      await _firebaseAuth.signOut();
    }
  }

  /// Send an verification email to an active user.
  Future<void> _verifyEmail() async {
    if (!await _isEmailVerified) {
      try {
        (await currentUser).sendEmailVerification();
      } on PlatformException {
        rethrow;
      }
    }
  }
}
