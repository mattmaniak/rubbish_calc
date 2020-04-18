import 'package:flutter_test/flutter_test.dart';

import 'src/initialization_tester.dart';
import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    final app = App();

    testInitialization(app, App);
    testInitialization(app.auth, Auth);

    test('A state should be initialized.', () {
      expect(app.createState(), isNotNull);
    });
  });
}
