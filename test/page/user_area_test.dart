import 'package:flutter_test/flutter_test.dart';

import '../src/common_tester.dart' as commonTester;
import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.UserArea', () {
    final userArea = page.UserArea(
      // TODO: MOCK CALLBACKS?
      switchPage: () {},
      signOut: () {},
    );

    commonTester.testNewObject(userArea, page.UserArea);

    test('Check if an anonymity flag was set properly.', () {
      expect(userArea.isUserAnonymous, isTrue);
    });

    test('Check state creation', () {
      expect(userArea.createState(), isNotNull);
    });
  });
}
