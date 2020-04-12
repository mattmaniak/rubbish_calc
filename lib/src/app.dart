import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/login_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rubbish Calc'),
      ),
      body: LoginPage(
        showScaffoldSnackbar: _showSnackbar,
      ),
    );
  }

  void _showSnackbar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
