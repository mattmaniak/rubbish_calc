import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page/page.dart' as page;
import '../../utils/common_tests.dart' as commonTests;

void main() {
  group('page.LoadingAnimation', () {
    final loadingAnimation = page.LoadingAnimation();
    commonTests.testNewObject(loadingAnimation, page.LoadingAnimation);

    testWidgets('Check it\'s descendants.', (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, loadingAnimation);

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });
}
