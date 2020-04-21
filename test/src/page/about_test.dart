import 'package:flutter_test/flutter_test.dart';

import '../../common_tests/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/page/page.dart' as page;

void main() {
  group('About', () {
    final about = page.About();
    commonTests.testNewObject(about, page.About);
  });
}
