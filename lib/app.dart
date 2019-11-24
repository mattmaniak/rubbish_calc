import 'package:flutter/material.dart';
import 'item.dart';

const String APP_TITLE = 'Rubbish Calc';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final DateTime _appInitDateTime = DateTime.now();
  final int _maxRubbishGrams = 1000000; // 1 metric ton.
  int _rubbishGrams = 0;
  bool _active = false;

  void _handleItemChanged(bool value) {
    setState(() {
      _active = value;
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
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Item(
                name: 'PET Bottle 0.5 L',
                weightGrams: 10,
                onChanged: _handleItemChanged,
                active: _active,
              )
            ]
          ),
          ClipOval(
            child: Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  this._rubbishGrams.toString() + ' grams produced since\n'
                  + this._appInitDateTime.toString() + '.',
                  textAlign: TextAlign.center
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
