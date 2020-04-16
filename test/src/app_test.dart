import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/app.dart';
import 'package:rubbish_calc/src/auth.dart';

void main() {
  test('The app module should initialize their members and launch methods.',
      () {
    final app = App();

    expect(app.auth == null, false);
    expect(app.auth.runtimeType, Auth);

    expect(app.createState() == null, false);
  });
}
