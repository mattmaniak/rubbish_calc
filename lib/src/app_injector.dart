import 'package:flutter/widgets.dart';

import 'package:rubbish_calc/src/auth.dart';

class AppInjector extends InheritedWidget {
  final Auth auth;
  final Function showSimpleAlertBox;
  final Function showSnackBar;
  final Function switchPage;
  final Widget child;

  const AppInjector(
      {@required this.child,
      @required this.auth,
      @required this.switchPage,
      @required this.showSimpleAlertBox,
      @required this.showSnackBar})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppInjector of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppInjector>();
}
