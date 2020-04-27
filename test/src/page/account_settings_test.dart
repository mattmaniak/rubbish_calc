import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rubbish_calc/src/page/page.dart' as page;
import '../../utils/common_tests.dart' as commonTests;

void main() {
  group('page.AccountSettings', () {
    final accountSettings = page.AccountSettings();

    commonTests.testNewStatefulWidget(accountSettings, page.AccountSettings);

    testWidgets('Locate page.AccountSettings widgets.',
        (WidgetTester tester) async {
      await commonTests.pumpWidget(tester, accountSettings);

      commonTests.findWidgetTypesNTimes([IconButton], 1);
      commonTests.findWidgetTypesNTimes([Icon], 2);
      commonTests.findWidgetTypesNTimes([FlatButton, RaisedButton]);

      await commonTests.tapButton(tester, find.byType(ExpansionTile));
      commonTests.findWidgetTypesNTimes([FlatButton, RaisedButton], 1);

      await commonTests.tapButton(tester, find.byType(Icon).last);
      commonTests.findWidgetTypesNTimes([FlatButton, RaisedButton]);
    });
  });
}
