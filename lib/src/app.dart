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
  var _visibleRoute = route.Visible.signedOut;

  @override
  Widget build(BuildContext context) {
    return AppInjector(
      auth: _auth,
      visibleRoute: _visibleRoute,
      changeRoute: _changeRoute,
      showSnackBar: _showScaffoldSnackBar,
      child: Scaffold(
        key: _scaffoldKey,
        body: route.Picker(),
      ),
    );
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
