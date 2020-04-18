import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import 'package:rubbish_calc/src/auth.dart';

class _MockAuth extends Mock implements Auth {
  bool _isSignedIn;

  @override
  Future<bool> get isUserSignedIn async => _isSignedIn;

  @override
  Future<String> signInAnonymously() async {
    _isSignedIn = true;
    return 'PROPER_TEST_USER_UID';
  }

  @override
  Future<void> signOut() async {
    _isSignedIn = false;
  }
}

void main() {
  group('Auth', () {
    final auth = _MockAuth();

    test('Check if an instance was created properly.', () {
      expect(auth == null, false);
      expect(auth.runtimeType, _MockAuth);
    });

    test('An anonymous user should sign in.', () async {
      auth.signInAnonymously();
      expect(await auth.isUserSignedIn, true);
    });

    test('An user should be signed out.', () async {
      auth.signOut();
      expect(await auth.isUserSignedIn, false);
    });
  });
}
