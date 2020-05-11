/// The primary file that connects all modules.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rubbish_calc/src/app_injector.dart';
import 'package:rubbish_calc/src/firebase/firebase.dart' as firebase;
import 'package:rubbish_calc/src/route/route.dart' as route;
import 'package:rubbish_calc/src/session_storage.dart';

/// Control all crucial modules and make an interaction between them possible.
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

/// Handle a state of the App.
class _AppState extends State<App> {
  final _auth = firebase.Auth();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _visibleRoute = route.Visible.loading;

  _AppState() {
    _tryToAutoSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AppInjector(
        auth: _auth,
        visibleRoute: _visibleRoute,
        changeRoute: _changeRoute,
        showSnackBar: _showScaffoldSnackBar,
        child: route.Picker(),
      ),
    );
  }

  Future<void> _tryToAutoSignIn() async {
    String email = await SessionStorage.email;
    String password = await SessionStorage.password;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await _auth.signIn(email, password);
      } on PlatformException {
        _changeRoute(route.Visible.signedOut);
      }
      _changeRoute(route.Visible.signedIn);
      return;
    }
    _changeRoute(route.Visible.signedOut);
  }

  /// Method used as a callback that provides switching between routes.
  void _changeRoute(route.Visible newPage) {
    setState(() {
      if (newPage != null) {
        _visibleRoute = newPage;
      } else {
        _visibleRoute = route.Visible.signedOut;
        _auth.signOut();
        SessionStorage.clear();
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
