import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../src/initialization_tester.dart';
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

    testInitialization(login, page.Login);
    testInitialization(login.auth, Auth);
    testInitialization(login.emailController, TextEditingController);
    testInitialization(login.passwordController, TextEditingController);
  });
}
