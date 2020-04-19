import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../test_src/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/auth.dart';

class _MockAuth extends Mock implements Auth {
  bool _isSignedIn;

  @override
  Future<bool> get isUserSignedIn async => _isSignedIn;

  @override
  Future<String> signIn(String email, String password) async {
    _isSignedIn = true;
    return 'TEST_EMAIL_USER_UID';
  }

  @override
  Future<String> signInAnonymously() async {
    _isSignedIn = true;
    return 'TEST_ANONYMOUS_USER_UID';
  }

  @override
  Future<void> signOut() async {
    _isSignedIn = false;
  }

  @override
  Future<String> signUp(String email, String password) async {
    _isSignedIn = true;
    return 'TEST_EMAIL_USER_UID';
  }
}

void main() {
  group('Auth', () {
    final auth = _MockAuth();

    commonTests.testNewObject(auth, _MockAuth);

    test('An anonymous user should sign in.', () async {
      auth.signInAnonymously();
      expect(await auth.isUserSignedIn, isTrue);
    });

    test('An user should be signed out.', () async {
      auth.signOut();
      expect(await auth.isUserSignedIn, isFalse);
    });
  });
}
