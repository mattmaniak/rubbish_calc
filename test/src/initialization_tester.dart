import 'package:flutter_test/flutter_test.dart';

void testInitialization(dynamic object, Type objectType) {
  test('Check if an object of $objectType was created properly.', () {
    expect(object, isNotNull);
    expect(object.runtimeType, objectType);
  });
}
