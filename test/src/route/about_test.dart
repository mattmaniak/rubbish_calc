import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/route/route.dart' as route;
import '../../utils/common_tests.dart' as commonTests;

void main() {
  group('About', () {
    final about = route.About();
    commonTests.testNewObject(about, route.About);
    testWidgets('Test how many items is included in the About route.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, about);
      commonTests.findWidgetTypesNTimes([Card, ListTile], 6);
    });
  });
}
