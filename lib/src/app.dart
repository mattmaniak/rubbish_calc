import 'package:flutter/material.dart';
import 'package:rubbish_calc/src/about.dart';
import 'package:rubbish_calc/src/dialog_box.dart';

import 'package:rubbish_calc/src/loading_animation.dart';
import 'package:rubbish_calc/src/login_page.dart';
import 'package:rubbish_calc/src/screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenProperties _currentScreen;
  var _currentScreenState = ScreenState.signed_out;

  @override
  Widget build(BuildContext context) {
    switch (_currentScreenState) {
      case ScreenState.signed_out:
        _currentScreen = ScreenProperties(
          appBarTitle: 'login',
          ui: LoginPage(
            updateScreenState: _updateScreenState,
            showScaffoldSnackBar: _showSnackBar,
            showScaffoldDialogBox: _showDialogBox,
          ),
        );
        break;

      case ScreenState.signed_in:
        // _body = LoginPage(
        //   showScaffoldSnackbar: _showSnackbar,
        // );
        break;

      case ScreenState.signed_in_anonymously:
        // _body = LoginPage(
        //   showScaffoldSnackbar: _showSnackbar,
        // );
        break;

      case ScreenState.about:
        _currentScreen = ScreenProperties(
          appBarTitle: 'about',
          ui: About(),
        );
        break;

      case ScreenState.loading:
        _currentScreen = ScreenProperties(
          appBarTitle: 'connecting...',
          ui: showLoadingAnimation(),
        );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rubbish Calc - ${_currentScreen.appBarTitle}'),
      ),
      body: _currentScreen.ui,
    );
  }

  void _showDialogBox(String title, String content) {
    showDialogBox(context, title, content);
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _updateScreenState(ScreenState state) {
    setState(() {
      _currentScreenState = state ?? ScreenState.signed_out;
      // TODO: LOG OUT FOR THE SAKE OF SECURITY.
    });
  }
}
