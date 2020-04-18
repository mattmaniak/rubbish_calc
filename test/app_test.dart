import 'package:flutter_test/flutter_test.dart';

import 'src/common_tester.dart' as commonTester;
import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    final app = App();

    commonTester.testNewObject(app, App);
    commonTester.testNewObject(app.auth, Auth);

    test('A state should be initialized.', () {
      expect(app.createState(), isNotNull);
    });
  });
}
