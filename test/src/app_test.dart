import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../common_tests/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  group('App', () {
    final app = App();
    commonTests.testNewStatefulWidget(app, App);
    // commonTests.testNewObject(app.auth, Auth);

    testWidgets('Check if the App\'s Scaffold used.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, app);
      commonTests.findWidgetTypesNTimes([Scaffold], 2);
    });
  });
}
