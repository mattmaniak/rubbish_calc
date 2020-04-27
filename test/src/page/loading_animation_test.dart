import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/route/route.dart' as route;
import '../../utils/common_tests.dart' as commonTests;

void main() {
  group('route.LoadingAnimation', () {
    final loadingAnimation = route.LoadingAnimation();
    commonTests.testNewObject(loadingAnimation, route.LoadingAnimation);

    testWidgets('Check it\'s descendants.', (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, loadingAnimation);

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });
}
