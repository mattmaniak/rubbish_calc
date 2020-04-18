import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    final app = App();

    test('Check if an instance was created properly.', () {
      expect(app == null, false);
      expect(app.runtimeType, App);
    });

    test('The auth member should be initialized properly.', () {
      expect(app.auth == null, false);
      expect(app.auth.runtimeType, Auth);
    });

    test('A state should be initialized.', () {
      expect(app.createState() == null, false);
    });
  });
}
