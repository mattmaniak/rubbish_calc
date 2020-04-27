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
  final auth = Auth();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  route.Visible _visiblePage = route.Visible.signedOut;
  Widget _currentPage;

  @override
  Widget build(BuildContext context) {
    _chooseCurrentPage();
    return AppInjector(
      auth: this.auth,
      switchPage: _switchPage,
      showSnackBar: _showScaffoldSnackBar,
      showSimpleAlertBox: _showScaffoldSimpleAlertDialog,
      child: Scaffold(
        key: _scaffoldKey,
        body: _currentPage,
      ),
    );
  }

  /// Decide which route will be displayed.
  void _chooseCurrentPage() {
    switch (_visiblePage) {
      case route.Visible.signedOut:
        _currentPage = route.LoginForm(
            // showAppSnackBar: _showScaffoldSnackBar,
            // showAppSimpleAlertDialog: _showScaffoldSimpleAlertDialog,
            );
        break;

      case route.Visible.signedIn:
        _currentPage = route.UserArea(
          isUserAnonymous: false,
        );
        break;

      case route.Visible.accountSettings:
        _currentPage = route.AccountSettings();
        break;

      case route.Visible.signedInAnonymously:
        _currentPage = route.UserArea();
        break;

      case route.Visible.about:
        _currentPage = route.About();
        break;

      case route.Visible.loading:
        _currentPage = route.LoadingAnimation();
    }
  }

  /// Method used as a callback that provides switching between routes.
  void _switchPage(route.Visible newPage) {
    setState(() {
      if (newPage != null) {
        _visiblePage = newPage;
      } else {
        auth.signOut();
        _visiblePage = route.Visible.signedOut;
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
