import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/main.dart';

Future<void> pumpWidget(WidgetTester tester, Widget child) async {
  return tester.pumpWidget(
    RootWidget(
      child: child,
    ),
  );
}

Future<void> testFormField(
    WidgetTester tester, Finder finder, String textToInput) async {
  await tester.enterText(finder, textToInput);
  expect(find.text(textToInput), findsOneWidget);
  await tester.enterText(finder, '');
}

Future<void> tapButton(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
}

void testNewObject(dynamic object, Type objectType) {
  _testNewObjectOnly(object, objectType);
}

void testNewStatefulWidget(dynamic widget, Type widgetType) {
  _testNewObjectOnly(widget, widgetType);
  test('Check if a state of $widgetType was created properly', () {
    expect(widget.createState(), isNotNull);
  });
}

void _testNewObjectOnly(dynamic object, Type objectType) {
  test('Check if an object of $objectType was created properly.', () {
    expect(object, isNotNull);
    expect(object.runtimeType, objectType);
  });
}
