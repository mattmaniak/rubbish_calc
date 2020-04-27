import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';
import '../common_tests/common_tests.dart' as commonTests;

void main() {
  group('App', () {
    final app = App();

    commonTests.testNewStatefulWidget(app, App);

    testWidgets('Check if the App\'s Scaffold used.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, app);
      commonTests.findWidgetTypesNTimes([Scaffold], 2);
    });
  });
}
