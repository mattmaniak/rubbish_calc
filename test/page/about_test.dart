import 'package:flutter_test/flutter_test.dart';

import '../src/common_tester.dart' as commonTester;

import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('About', () {
    final about = page.About();
    commonTester.testNewObject(about, page.About);
  });
}
