import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_test.dart';
import 'package:rubbish_calc/src/app_injector.dart';
import '../utils/common_tests.dart' as commonTests;

void main() {
  group('AppInjector', () {
    final appInjector = AppInjector(
      auth: MockAuth(),
      isLoading: false,
      showSnackBar: () {},
      changeRoute: () {},
      child: Scaffold(),
    );

    commonTests.testNewObject(appInjector, AppInjector);

    test('Test AppInjector\'s methods', () {
      expect(appInjector.updateShouldNotify(appInjector), isTrue);
    });
  });
}
