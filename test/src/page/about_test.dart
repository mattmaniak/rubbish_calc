import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('About', () {
    final about = page.About();

    test('Check if an instance was created properly.', () {
      expect(about == null, false);
      expect(about.runtimeType, page.About);
    });
  });
}
