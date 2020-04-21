import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../common_tests/common_tests.dart' as commonTests;
import '../src/page/login_form_test.dart';
import 'package:rubbish_calc/src/auth.dart';

class _MockAuth extends Mock implements Auth {
  bool isUserSignedIn = false;
  bool isEmailVerified = false;

  @override
  Future<String> signIn(String email, String password) async {
    isEmailVerified = true;
    isUserSignedIn = true;
    return 'TEST_SIGNED_IN_USER_UID';
  }

  @override
  Future<String> signInAnonymously() async {
    isUserSignedIn = true;
    return 'TEST_SIGNED_IN_ANONYOMOUS_USER_UID';
  }

  @override
  Future<void> signOut() async {
    isUserSignedIn = false;
  }

  @override
  Future<String> signUp(String email, String password) async {
    isUserSignedIn = true;
    return 'TEST_SIGNED_UP_USER_UID';
  }
}

void main() {
  group('Auth', () {
    final auth = _MockAuth();

    void testSignOut() {
      test('An user should be signed out.', () async {
        auth.signOut();
        expect(auth.isUserSignedIn, isFalse);
      });
    }

    commonTests.testNewObject(auth, _MockAuth);

    test('An anonymous user should sign in.', () async {
      auth.signInAnonymously();
      expect(auth.isUserSignedIn, isTrue);
    });
    testSignOut();

    test('An user should sign up using provided credentials.', () async {
      auth.signUp(EXAMPLE_EMAIL, EXAMPLE_PASSWORD);
      expect(auth.isUserSignedIn, isTrue);
    });
    testSignOut();

    test('An user should sign in using provided credentials.', () async {
      auth.signIn(EXAMPLE_EMAIL, EXAMPLE_PASSWORD);
      expect(auth.isEmailVerified, isTrue);
      expect(auth.isUserSignedIn, isTrue);
    });
    testSignOut();
  });
}
