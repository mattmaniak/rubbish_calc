import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../src/common_tester.dart' as commonTester;
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

    commonTester.testNewObject(login, page.Login);
    commonTester.testNewObject(login.auth, Auth);
    commonTester.testNewObject(login.emailController, TextEditingController);
    commonTester.testNewObject(login.passwordController, TextEditingController);
  });
}
