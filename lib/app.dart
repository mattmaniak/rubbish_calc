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
  int _active = 0;

  void _handleItemChanged(int value) {
    setState(() {
      _active = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(Icons.scatter_plot),
            pinned: true,
            floating: true,
            expandedHeight: 256.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Rubbish Calc',
                style: TextStyle(color: Colors.black),
              ),
              background: Center(
                child: Text(
                  (_active * 10).toString() + ' g',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Item(
                  name: 'PET Bottle 0.5 L',
                  weightGrams: 10,
                  onChanged: _handleItemChanged,
                  amountInRubbish: _active,
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}
