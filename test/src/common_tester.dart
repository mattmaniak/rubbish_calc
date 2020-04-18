import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void testNewObject(dynamic object, Type objectType) {
  test('Check if an object of $objectType was created properly.', () {
    expect(object, isNotNull);
    expect(object.runtimeType, objectType);
  });
}

Future<void> pumpScaffold(WidgetTester tester, Widget home) async {
  return tester.pumpWidget(MaterialApp(
    home: home,
  ));
}
