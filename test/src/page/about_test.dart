import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page/page.dart' as page;
import '../../common_tests/common_tests.dart' as commonTests;

void main() {
  group('About', () {
    final about = page.About();
    commonTests.testNewObject(about, page.About);
    testWidgets('Test how many items is included in the About page.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, about);
      commonTests.findWidgetTypesNTimes([Card, ListTile], 6);
    });
  });
}
