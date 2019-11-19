import 'package:flutter/material.dart';
import 'calc.dart';
import 'rubbish.dart';

const String APP_TITLE = 'Rubbish Calc';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final DateTime _appInitDateTime = DateTime.now();
  final int _maxRubbishGrams = 1000000; // 1 metric ton.
  int _rubbishGrams = 0;

  void _incrementRubbishGrams() {
    setState(() {
      if(_rubbishGrams < _maxRubbishGrams) {
        _rubbishGrams++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          APP_TITLE,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            tooltip: 'Add task',
            onPressed: _incrementRubbishGrams,
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: items.toList(),
          ),
          CalcDisplay(
            rubbishGrams: this._rubbishGrams,
            rubbishCreationDateTime: this._appInitDateTime
          ),
        ]
      ),
    );
  }
}
