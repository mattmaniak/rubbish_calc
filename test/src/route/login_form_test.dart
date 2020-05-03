import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/route/route.dart' as route;
import '../../utils/common_tests.dart' as commonTests;

const String EXAMPLE_EMAIL = 'johndoe@example.com';
const String EXAMPLE_PASSWORD = '___TestPasswor6___';

void main() {
  group('route.LoginForm', () {
    final login = route.LoginForm();

    commonTests.testNewStatefulWidget(login, route.LoginForm);
    commonTests.testNewObject(login.emailController, TextEditingController);
    commonTests.testNewObject(login.passwordController, TextEditingController);

    testWidgets('Test the TextFormField inputs.', (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, login);

      commonTests.findWidgetTypesNTimes([Form, Checkbox], 1);
      commonTests
          .findWidgetTypesNTimes([TextFormField, FlatButton, RaisedButton], 2);
      commonTests.findWidgetTypesNTimes([Divider], 4);

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
    });
  });
}
