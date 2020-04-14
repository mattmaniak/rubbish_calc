/// The primary file that connects all modules.

import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/page.dart' as page;
import 'package:rubbish_calc/src/simple_dialog_box.dart';

/// Control all crucial modules and make an interaction between them possible.
class App extends StatefulWidget {
  final auth = Auth();

  @override
  _AppState createState() => _AppState();
}

/// Handle a state of the App.
class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  page.Mode _currentPage = page.Mode.signedOut;
  Widget _pageUi;

  @override
  Widget build(BuildContext context) {
    _chooseCurrentPage();
    return Scaffold(
      key: _scaffoldKey,
      body: _pageUi,
    );
  }

  /// Decide which page will be displayed.
  void _chooseCurrentPage() {
    switch (_currentPage) {
      case page.Mode.signedOut:
        _pageUi = page.Login(
          auth: widget.auth,
          changeScreenState: _changeScreenState,
          showAppSnackBar: _showScaffoldSnackBar,
          showAppSimpleAlertDialog: _showScaffoldSimpleAlertDialog,
        );
        break;

      case page.Mode.signedIn:
        _pageUi = page.UserArea(
          isUserAnonymous: false,
        );
        break;

      case page.Mode.signedInAnonymously:
        _pageUi = page.UserArea();
        break;

      case page.Mode.about:
        _pageUi = page.About();
        break;

      case page.Mode.loading:
        _pageUi = page.LoadingAnimation();
    }
  }

  /// Method used as a callback that provides switching between pages.
  void _changeScreenState(page.Mode state) {
    setState(() {
      _currentPage = state ?? page.Mode.signedOut;
      // TODO: LOG OUT FOR THE SAKE OF SECURITY.
    });
  }

  /// Method used as a callback that shows a dialog box in the App's Scaffold.
  void _showScaffoldSimpleAlertDialog(String title, String content) =>
      showSimpleAlertDialog(context, title, content);

  /// Method used as a callback that shows a snack bar in the App's Scaffold.
  void _showScaffoldSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text ?? ''),
      ),
    );
  }
}
