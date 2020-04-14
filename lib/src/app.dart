import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/dialog_box.dart';
import 'package:rubbish_calc/src/page.dart' as page;

class App extends StatefulWidget {
  final auth = Auth();
  final String appName;

  App({this.appName});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  page.Page _currentScreen;
  var _currentScreenState = page.Mode.signedOut;

  @override
  Widget build(BuildContext context) {
    switch (_currentScreenState) {
      case page.Mode.signedOut:
        _currentScreen = page.Page(
          appBarTitleSufix: 'login',
          ui: page.Login(
            auth: widget.auth,
            changeScreenState: _changeScreenState,
            showScaffoldSnackBar: _showSnackBar,
            showScaffoldDialogBox: _showDialogBox,
          ),
        );
        break;

      case page.Mode.signedIn:
        _currentScreen = page.Page(
          appBarTitleSufix: widget.auth.currentUser.toString(),
          ui: page.UserArea(),
        );
        break;

      case page.Mode.signedInAnonymously:
        _currentScreen = page.Page(
          appBarTitleSufix: 'anonymous user',
          ui: page.UserArea(),
        );
        break;

      case page.Mode.about:
        _currentScreen = page.Page(
          appBarTitleSufix: 'about',
          ui: page.About(),
        );
        break;

      case page.Mode.loading:
        _currentScreen = page.Page(
          appBarTitleSufix: 'connecting...',
          ui: page.showLoadingAnimation(),
        );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.appName} - ${_currentScreen.appBarTitleSufix}'),
      ),
      body: _currentScreen.ui,
      floatingActionButton: _currentScreenState == page.Mode.signedIn
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {},
            )
          : null,
    );
  }

  void _changeScreenState(page.Mode state) {
    setState(() {
      _currentScreenState = state ?? page.Mode.signedOut;
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
