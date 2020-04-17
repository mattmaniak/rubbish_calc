import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('Create a page.Login instance.', () {
      expect(login == null, false);
      expect(login.runtimeType, page.Login);
    });

    test('Check if a auth module given as an argument is valid.', () {
      expect(login.auth == null, false);
      expect(login.auth.runtimeType, Auth);
    });

    test('Initialize the email form field controller.', () {
      expect(login.emailController == null, false);
      expect(login.emailController.runtimeType, TextEditingController);
    });

    test('Initialize the password form field controller.', () {
      expect(login.passwordController == null, false);
      expect(login.passwordController.runtimeType, TextEditingController);
    });
  });
}
