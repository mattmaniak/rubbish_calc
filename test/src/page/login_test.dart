import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/page.dart' as page;

void main() {
  test(
      'The login page should initialize text inputs and receive an instance of Auth().',
      () {
    final login = page.Login(
      // TODO: MOCK CALLBACKS?
      auth: Auth(),
      showAppSimpleAlertDialog: () {},
      switchPage: () {},
      showAppSnackBar: () {},
    );

    expect(login.auth == null, false);
    expect(login.auth.runtimeType, Auth);

    expect(login.emailController == null, false);
    expect(login.emailController.runtimeType, TextEditingController);

    expect(login.passwordController == null, false);
    expect(login.passwordController.runtimeType, TextEditingController);
  });
}
