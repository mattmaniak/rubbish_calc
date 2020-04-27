/// The primary file that connects all modules.

import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/app_injector.dart';
import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/route/route.dart' as route;
import 'package:rubbish_calc/src/simple_alert_dialog.dart';

/// Control all crucial modules and make an interaction between them possible.
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

/// Handle a state of the App.
class _AppState extends State<App> {
  final _auth = Auth();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  route.Visible _visibleRoute = route.Visible.signedOut;
  Widget _currentRoute;

  @override
  Widget build(BuildContext context) {
    double routeOpacity = 1.0;
    List<Widget> children = [];

    _chooseCurrentPage();
    if (_visibleRoute == route.Visible.loading) {
      routeOpacity = 0.0;
      children.add(route.LoadingAnimation());
      _hideKeyboard();
    }
    children.add(
      Opacity(
        opacity: routeOpacity,
        child: _currentRoute,
      ),
    );

    return AppInjector(
      auth: _auth,
      switchPage: _switchPage,
      showSnackBar: _showScaffoldSnackBar,
      showSimpleAlertBox: _showScaffoldSimpleAlertDialog,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: children,
        ),
      ),
    );
  }

  /// Decide which route will be displayed.
  void _chooseCurrentPage() {
    switch (_visibleRoute) {
      case route.Visible.signedOut:
        _currentRoute = route.LoginForm();
        break;

      case route.Visible.signedIn:
        _currentRoute = route.UserArea(
          isUserAnonymous: false,
        );
        break;

      case route.Visible.accountSettings:
        _currentRoute = route.AccountSettings();
        break;

      case route.Visible.signedInAnonymously:
        _currentRoute = route.UserArea();
        break;

      case route.Visible.about:
        _currentRoute = route.About();
        break;

      case route.Visible.loading:
    }
  }

  /// Force to hide an expanded keyboard.
  void _hideKeyboard() => FocusScope.of(context).requestFocus(FocusNode());


  /// Method used as a callback that provides switching between routes.
  void _switchPage(route.Visible newPage) {
    setState(() {
      if (newPage != null) {
        _visibleRoute = newPage;
      } else {
        _auth.signOut();
        _visibleRoute = route.Visible.signedOut;
      }
    });
  }

  /// Method used as a callback that shows a dialog box in the App's Scaffold.
  void _showScaffoldSimpleAlertDialog(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleAlertDialog(
        title: title ?? 'Something broke...',
        content: content ?? 'Unknown error.',
      ),
    );
  }

  /// Method used as a callback that shows a snack bar in the App's Scaffold.
  void _showScaffoldSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text ?? ''),
      ),
    );
  }
}
