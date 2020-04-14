import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/dialog_box.dart';
import 'package:rubbish_calc/src/screen.dart' as screen;

class App extends StatefulWidget {
  final auth = Auth();
  final String appName;

  App({this.appName});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  screen.Screen _currentScreen;
  var _currentScreenState = screen.Mode.signedOut;

  @override
  Widget build(BuildContext context) {
    switch (_currentScreenState) {
      case screen.Mode.signedOut:
        _currentScreen = screen.Screen(
          appBarTitleSufix: 'login',
          ui: screen.Login(
            auth: widget.auth,
            changeScreenState: _changeScreenState,
            showScaffoldSnackBar: _showSnackBar,
            showScaffoldDialogBox: _showDialogBox,
          ),
        );
        break;

      case screen.Mode.signedIn:
        _currentScreen = screen.Screen(
          appBarTitleSufix: widget.auth.currentUser.toString(),
          ui: screen.UserArea(),
        );
        break;

      case screen.Mode.signedInAnonymously:
        _currentScreen = screen.Screen(
          appBarTitleSufix: 'anonymous user',
          ui: screen.UserArea(),
        );
        break;

      case screen.Mode.about:
        _currentScreen = screen.Screen(
          appBarTitleSufix: 'about',
          ui: screen.About(),
        );
        break;

      case screen.Mode.loading:
        _currentScreen = screen.Screen(
          appBarTitleSufix: 'connecting...',
          ui: screen.showLoadingAnimation(),
        );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.appName} - ${_currentScreen.appBarTitleSufix}'),
      ),
      body: _currentScreen.ui,
      floatingActionButton: _currentScreenState == screen.Mode.signedIn
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {},
            )
          : null,
    );
  }

  void _changeScreenState(screen.Mode state) {
    setState(() {
      _currentScreenState = state ?? screen.Mode.signedOut;
      // TODO: LOG OUT FOR THE SAKE OF SECURITY.
    });
  }

  void _showDialogBox(String title, String content) {
    showDialogBox(context, title, content);
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text ?? ''),
      ),
    );
  }
}
