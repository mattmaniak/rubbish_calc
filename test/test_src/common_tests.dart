import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpWidget(WidgetTester tester, Widget home) async {
  return tester.pumpWidget(MaterialApp(
    home: home,
  ));
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
