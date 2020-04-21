import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common_tests/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/page/page.dart' as page;

void main() {
  group('page.LoadingAnimation', () {
    final loadingAnimation = page.LoadingAnimation();
    commonTests.testNewObject(loadingAnimation, page.LoadingAnimation);

    testWidgets('', (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, loadingAnimation);

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
