import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    final app = App();

    test('Create an instance.', () {
      expect(app == null, false);
      expect(app.runtimeType, App);
    });

    test('The auth member should be initialized properply.', () {
      expect(app.auth == null, false);
      expect(app.auth.runtimeType, Auth);
    });

    test('A state should be initialized.', () {
      expect(app.createState() == null, false);
    });
  });
}
