/// The primary file that connects all modules.

import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/dialog_box.dart';
import 'package:rubbish_calc/src/page.dart' as page;

class App extends StatefulWidget {
  final auth = Auth();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  page.Mode _currentScreenState = page.Mode.signedOut;
  Widget _ui;

  @override
  Widget build(BuildContext context) {
    switch (_currentScreenState) {
      case page.Mode.signedOut:
        _ui = page.Login(
          auth: widget.auth,
          changeScreenState: _changeScreenState,
          showAppSnackBar: _showScaffoldSnackBar,
          showAppDialogBox: _showScaffoldDialogBox,
        );
        break;

      case page.Mode.signedIn:
        _ui = page.UserArea(
          isUserAnonymous: false,
        );
        break;

      case page.Mode.signedInAnonymously:
        _ui = page.UserArea();
        break;

      case page.Mode.about:
        _ui = page.About();
        break;

      case page.Mode.loading:
        _ui = page.LoadingAnimation();
    }
    return Scaffold(
      key: _scaffoldKey,
      body: _ui,
    );
  }

  void _changeScreenState(page.Mode state) {
    setState(() {
      _currentScreenState = state ?? page.Mode.signedOut;
      // TODO: LOG OUT FOR THE SAKE OF SECURITY.
    });
  }

  void _showScaffoldDialogBox(String title, String content) =>
      showDialogBox(context, title, content);

  void _showScaffoldSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text ?? ''),
      ),
    );
  }
}
