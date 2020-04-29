/// The primary file that connects all modules.

import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/app_injector.dart';
import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/route/route.dart' as route;

/// Control all crucial modules and make an interaction between them possible.
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

/// Handle a state of the App.
class _AppState extends State<App> {
  final _auth = Auth();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  Widget _currentRoute;
  var _visibleRoute = route.Visible.signedOut;

  @override
  Widget build(BuildContext context) {
    _chooseCurrentPage();

    return AppInjector(
      auth: _auth,
      isLoading: _isLoading,
      changeRoute: _changeRoute,
      showSnackBar: _showScaffoldSnackBar,
      // showSimpleAlertBox: _showScaffoldSimpleAlertDialog,
      child: Scaffold(
        key: _scaffoldKey,
        body: _currentRoute,
      ),
    );
  }

  /// Decide which route will be displayed.
  void _chooseCurrentPage() {
    _isLoading = false;

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
        _isLoading = true;
    }
  }

  /// Method used as a callback that provides switching between routes.
  void _changeRoute(route.Visible newPage) {
    setState(() {
      if (newPage != null) {
        _visibleRoute = newPage;
      } else {
        _auth.signOut();
        _visibleRoute = route.Visible.signedOut;
      }
    });
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
