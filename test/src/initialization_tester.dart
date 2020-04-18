import 'package:flutter_test/flutter_test.dart';

void testInitialization(dynamic object, Type objectType) {
  test('Check if an instance was created properly.', () {
    expect(object == null, false);
    expect(object.runtimeType, objectType);
  });
}
