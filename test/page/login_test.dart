import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../src/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  group('page.Login', () {
    final login = page.Login(
      // TODO: MOCK CALLBACKS?
      auth: Auth(),
      switchPage: () {},
      showAppSimpleAlertDialog: () {},
      showAppSnackBar: () {},
    );

    commonTests.testNewObject(login, page.Login);
    commonTests.testNewObject(login.auth, Auth);
    commonTests.testNewObject(login.emailController, TextEditingController);
    commonTests.testNewObject(login.passwordController, TextEditingController);
  });
}
