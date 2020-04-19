import 'package:flutter_test/flutter_test.dart';

import 'src/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    final app = App();
    commonTests.testNewStatefulWidget(app, App);
    commonTests.testNewObject(app.auth, Auth);
  });
}
