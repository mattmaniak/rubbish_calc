import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/dialog_box.dart';
import 'package:rubbish_calc/src/screen/loading_animation.dart';
import 'package:rubbish_calc/src/screen/about.dart';
import 'package:rubbish_calc/src/screen/login.dart';
import 'package:rubbish_calc/src/screen/screen.dart';
import 'package:rubbish_calc/src/screen/user_area.dart';

class App extends StatefulWidget {
  final auth = Auth();
  final String appName;

  App({this.appName});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenProperties _currentScreen;
  var _currentScreenState = ScreenState.signedOut;

  @override
  Widget build(BuildContext context) {
    switch (_currentScreenState) {
      case ScreenState.signedOut:
        _currentScreen = ScreenProperties(
          appBarTitleSufix: 'login',
          ui: ScreenLogin(
            auth: widget.auth,
            changeScreenState: _changeScreenState,
            showScaffoldSnackBar: _showSnackBar,
            showScaffoldDialogBox: _showDialogBox,
          ),
        );
        break;

      case ScreenState.signedIn:
        _currentScreen = ScreenProperties(
          appBarTitleSufix: widget.auth.currentUser.toString(),
          ui: UserArea(),
        );
        break;

      case ScreenState.signedInAnonymously:
        _currentScreen = ScreenProperties(
          appBarTitleSufix: 'anonymous user',
          ui: UserArea(),
        );
        break;

      case ScreenState.about:
        _currentScreen = ScreenProperties(
          appBarTitleSufix: 'about',
          ui: About(),
        );
        break;

      case ScreenState.loading:
        _currentScreen = ScreenProperties(
          appBarTitleSufix: 'connecting...',
          ui: showLoadingAnimation(),
        );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.appName} - ${_currentScreen.appBarTitleSufix}'),
      ),
      body: _currentScreen.ui,
      floatingActionButton: _currentScreenState == ScreenState.signedIn
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {},
            )
          : null,
    );
  }

  void _changeScreenState(ScreenState state) {
    setState(() {
      _currentScreenState = state ?? ScreenState.signedOut;
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
