import 'package:flutter/widgets.dart';

import 'package:rubbish_calc/src/auth.dart';

class InheritedApp extends InheritedWidget {
  final Auth auth;
  final Function switchPage;
  final Widget child;

  const InheritedApp(
      {@required this.auth, @required this.switchPage, @required this.child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedApp of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedApp>();
}
