import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.UserArea', () {
    final userArea = page.UserArea(
      // TODO: MOCK CALLBACKS?
      switchPage: () {},
      signOut: () {},
    );

    test('Check if an instance was created properly.', () {
      expect(userArea == null, false);
      expect(userArea.runtimeType, page.UserArea);
      expect(userArea.isUserAnonymous, true);
    });

    test('Check state creation', () {
      expect(userArea.createState() == null, false);
    });
  });
}
