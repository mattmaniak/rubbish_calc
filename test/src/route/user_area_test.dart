import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/route/route.dart' as route;
import '../../utils/common_tests.dart' as commonTests;

void main() {
  group('Anonymous route.UserArea', () {
    final userArea = route.UserArea();
    commonTests.testNewStatefulWidget(userArea, route.UserArea);

    test('Check if an anonymity flag was set properly.', () {
      expect(userArea.isUserAnonymous, isTrue);
    });

    testWidgets('Find some descendants for an anonymous user UI.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, userArea);
      commonTests.findWidgetTypesNTimes([IconButton], 1);
      commonTests.findWidgetTypesNTimes([Icon], 2);
    });
  });

  group('Page.UserArea but for an email user.', () {
    final userArea = route.UserArea(
      isUserAnonymous: false,
    );
    commonTests.testNewStatefulWidget(userArea, route.UserArea);

    test('Check if an anonymity flag was unset.', () {
      expect(userArea.isUserAnonymous, isFalse);
    });

    testWidgets('Find some descendants for an email user UI.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, userArea);

      commonTests.findWidgetTypesNTimes([Scaffold, FloatingActionButton], 1);
      commonTests.findWidgetTypesNTimes([IconButton], 2);
      commonTests.findWidgetTypesNTimes([Icon], 3);
    });
  });
}
