import 'package:flutter_test/flutter_test.dart';

import '../src/initialization_tester.dart';

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.LoadingAnimation', () {
    final loadingAnimation = page.LoadingAnimation();
    testInitialization(loadingAnimation, page.LoadingAnimation);
  });
}
