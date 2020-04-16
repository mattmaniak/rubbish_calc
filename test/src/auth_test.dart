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
  TestWidgetsFlutterBinding.ensureInitialized();
  test('The app should sign in and out anonymously.', () async {
    final auth = _MockAuth();

    auth.signInAnonymously();
    expect(await auth.isUserSignedIn, true);
    auth.signOut();
    expect(await auth.isUserSignedIn, false);
  });
}
