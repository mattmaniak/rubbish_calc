import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../src/common_tester.dart' as commonTester;

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.LoadingAnimation', () {
    final loadingAnimation = page.LoadingAnimation();
    commonTester.testNewObject(loadingAnimation, page.LoadingAnimation);

    testWidgets('', (WidgetTester tester) async {
      await commonTester.pumpScaffold(tester, loadingAnimation);
      expect(find.byType(Scaffold), findsOneWidget);

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Rubbish Calc - loading...'), findsOneWidget);

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
