import 'package:flutter/material.dart';

const String APP_TITLE = 'Rubbish Calc';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final int _maxTrashAmountKg = 16;
  int _trashAmountKg = 0;

  void _incrementTrashAmount() {
    setState(() {
      if(_trashAmountKg < _maxTrashAmountKg) {
      _trashAmountKg++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add task',
            onPressed: _incrementTrashAmount,
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Text(_trashAmountKg.toString() + ' kg')],
      ),
    );
  }
}
