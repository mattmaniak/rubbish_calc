import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/route/route.dart' as route;
import '../../utils/common_tests.dart' as commonTests;

void main() {
  group('route.AccountSettings', () {
    final accountSettings = route.AccountSettings();

    commonTests.testNewStatefulWidget(accountSettings, route.AccountSettings);

    testWidgets('Locate route.AccountSettings widgets.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, accountSettings);

      commonTests.findWidgetTypesNTimes([Icon], 2);
      commonTests.findWidgetTypesNTimes([FlatButton, RaisedButton]);

      await commonTests.tapButton(tester, find.byType(ExpansionTile));
      commonTests.findWidgetTypesNTimes([FlatButton, RaisedButton], 1);

      await commonTests.tapButton(tester, find.byType(Icon).last);
      commonTests.findWidgetTypesNTimes([FlatButton, RaisedButton]);
    });
  });
}
