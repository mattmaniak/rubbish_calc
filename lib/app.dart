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

  // https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
  // https://www.quora.com/How-much-does-a-330ml-can-of-soda-weigh-in-grams
  final List<Item> _rubbish = [
    Item(
      name: 'PET Bottle 0.5 L',
      weightGrams: 10,
    ),
    Item(
      name: 'PET Bottle 1.0 L',
      weightGrams: 20,
    ),
    Item(
      name: 'PET Bottle 1.5 L',
      weightGrams: 30,
    ),
    Item(
      name: 'Aluminium soda can 0.33 L',
      weightGrams: 360,
    ),
  ];
  int _rubbishGrams = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(slivers: <Widget>[
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
            background: Center(child: Text(_rubbishGrams.toString() + ' g')),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(_rubbish)),
      ]),
    );
  }

  int _countRubbishGrams() {
    setState(() {
      _rubbish.forEach((item) {
        _rubbishGrams += item.amountInRubbish * item.weightGrams;
        if (_rubbishGrams > _maxRubbishGrams) {
          _rubbishGrams = 0;
        }
      });
    });
  }
}
