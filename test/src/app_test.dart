import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    test('The auth member should be initialized properply.', () {
      final app = App();
      expect(app.auth == null, false);
      expect(app.auth.runtimeType, Auth);
    });

    test('A state should be initialized.', () {
      final app = App();
      expect(app.createState() == null, false);
    });
  });
}
