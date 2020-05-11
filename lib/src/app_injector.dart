import 'package:flutter/widgets.dart';

import 'package:rubbish_calc/src/firebase/firebase.dart' as firebase;
import 'package:rubbish_calc/src/route/route.dart' as route;

class AppInjector extends InheritedWidget {
  final firebase.Auth auth;
  final Function showSnackBar;
  final Function changeRoute;
  final Widget child;
  final route.Visible visibleRoute;

  const AppInjector(
      {@required this.child,
      @required this.visibleRoute,
      @required this.auth,
      @required this.changeRoute,
      @required this.showSnackBar})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  /// Provide an access to all the members.
  static AppInjector of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppInjector>();
}
