import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.LoadingAnimation', () {
    final loadingAnimation = page.LoadingAnimation();

    test('Check if an instance was created properly.', () {
      expect(loadingAnimation == null, false);
      expect(loadingAnimation.runtimeType, page.LoadingAnimation);
    });
  });
}
