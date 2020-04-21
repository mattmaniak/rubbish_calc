import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common_tests/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/page/page.dart' as page;

void main() {
  group('Anonymous page.UserArea', () {
    final userArea = page.UserArea(
      // TODO: MOCK CALLBACKS?
      switchPage: () {},
      signOut: () {},
    );
    commonTests.testNewStatefulWidget(userArea, page.UserArea);

    test('Check if an anonymity flag was set properly.', () {
      expect(userArea.isUserAnonymous, isTrue);
    });

    testWidgets('Find some descendants for an anonymous user UI.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, userArea);
      commonTests.findWidgetTypesNTimes([IconButton, Icon], 1);
    });
  });

  group('Page.UserArea but for an email user.', () {
    final userArea = page.UserArea(
      // TODO: MOCK CALLBACKS?
      switchPage: () {},
      signOut: () {},
      isUserAnonymous: false,
    );
    commonTests.testNewStatefulWidget(userArea, page.UserArea);

    test('Check if an anonymity flag was unset.', () {
      expect(userArea.isUserAnonymous, isFalse);
    });

    testWidgets('Find some descendants for an email user UI.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, userArea);
      commonTests.findWidgetTypesNTimes([IconButton, FloatingActionButton], 1);
      commonTests.findWidgetTypesNTimes([Icon], 2);
    });
  });
}
