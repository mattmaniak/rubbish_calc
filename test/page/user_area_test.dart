import 'package:flutter_test/flutter_test.dart';

import '../src/initialization_tester.dart';
import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.UserArea', () {
    final userArea = page.UserArea(
      // TODO: MOCK CALLBACKS?
      switchPage: () {},
      signOut: () {},
    );

    testInitialization(userArea, page.UserArea);

    test('Check if an anonymity flag was set properly.', () {
      expect(userArea.isUserAnonymous, true);
    });

    test('Check state creation', () {
      expect(userArea.createState() == null, false);
    });
  });
}
