import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common_tests/common_tests.dart' as commonTests;
import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/page.dart' as page;

const String EXAMPLE_EMAIL = 'johndoe@example.com';
const String EXAMPLE_PASSWORD = '___TestPasswor6___';

void main() {
  group('page.Login', () {
    final login = page.Login(
      // TODO: MOCK CALLBACKS?
      auth: Auth(),
      switchPage: () {},
      showAppSimpleAlertDialog: () {},
      showAppSnackBar: () {},
    );

    commonTests.testNewStatefulWidget(login, page.Login);
    commonTests.testNewObject(login.auth, Auth);
    commonTests.testNewObject(login.emailController, TextEditingController);
    commonTests.testNewObject(login.passwordController, TextEditingController);

    testWidgets('Test the TextFormField inputs.', (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, login);

      await commonTests.testFormField(
          tester, find.byType(TextFormField).first, EXAMPLE_EMAIL);
      await commonTests.testFormField(
          tester, find.byType(TextFormField).last, EXAMPLE_PASSWORD);

      await commonTests.tapButton(tester, find.byType(RaisedButton).first);
      expect(find.text('Email field can\'t be empty.'), findsOneWidget);
      expect(find.text('Password field can\'t be empty.'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, 'johndoe@');
      await tester.enterText(find.byType(TextFormField).last, 'pass');
      await commonTests.tapButton(tester, find.byType(RaisedButton).first);
      expect(find.text('Invalid email format.'), findsOneWidget);
      expect(
          find.text('Use at least 12 chars with number and uppercase letter.'),
          findsOneWidget);
    });
  });
}
