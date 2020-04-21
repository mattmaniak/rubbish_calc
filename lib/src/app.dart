/// The primary file that connects all modules.

import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/simple_alert_dialog.dart';
import 'package:rubbish_calc/src/page/page.dart' as page;

/// Control all crucial modules and make an interaction between them possible.
class App extends StatefulWidget {
  final auth = Auth();

  @override
  _AppState createState() => _AppState();
}

/// Handle a state of the App.
class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  page.Visible _visiblePage = page.Visible.signedOut;
  Widget _currentPage;

  @override
  Widget build(BuildContext context) {
    _chooseCurrentPage();
    return Scaffold(
      key: _scaffoldKey,
      body: _currentPage,
    );
  }

  /// Decide which page will be displayed.
  void _chooseCurrentPage() {
    switch (_visiblePage) {
      case page.Visible.signedOut:
        _currentPage = page.LoginForm(
          auth: widget.auth,
          switchPage: _switchPage,
          showAppSnackBar: _showScaffoldSnackBar,
          showAppSimpleAlertDialog: _showScaffoldSimpleAlertDialog,
        );
        break;

      case page.Visible.signedIn:
        _currentPage = page.UserArea(
          switchPage: _switchPage,
          signOut: widget.auth.signOut,
          isUserAnonymous: false,
        );
        break;

      case page.Visible.signedInAnonymously:
        _currentPage = page.UserArea(
          switchPage: _switchPage,
          signOut: widget.auth.signOut,
        );
        break;

      case page.Visible.about:
        _currentPage = page.About();
        break;

      case page.Visible.loading:
        _currentPage = page.LoadingAnimation();
    }
  }

  /// Method used as a callback that provides switching between pages.
  void _switchPage(page.Visible newPage) {
    setState(() {
      if (newPage != null) {
        _visiblePage = newPage;
      } else {
        widget.auth.signOut();
        _visiblePage = page.Visible.signedOut;
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
