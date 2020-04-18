import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.LoadingAnimation', () {
    final loadingAnimation = page.LoadingAnimation();

    test('Create an instance.', () {
      expect(loadingAnimation == null, false);
      expect(loadingAnimation.runtimeType, page.LoadingAnimation);
    });
  });
}
