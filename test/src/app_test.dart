import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/app.dart';

void main() {
  test('The app should initialize their members and launch methods.', () {
    final app = App();
    expect(app.auth == null, false);
    expect(app.createState() == null, false);
  });
}
