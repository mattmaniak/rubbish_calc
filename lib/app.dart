import 'package:flutter/material.dart';
import 'item.dart';

class App extends StatefulWidget {
  final String appTitle;

  App({@required this.appTitle});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final int _maxRubbishGrams = 1000000; // 1 metric ton.
  int _rubbishGrams = 0;
  String _appInitDate;
  int amount = 0;

  ValueChanged<int> onChanged;

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
      weightGrams: 30,
    ),
  ];

  @override
  void initState() {
    super.initState();

    final DateTime appInitDateTime = DateTime.now();
    _appInitDate = appInitDateTime.year.toString() +
        '-' +
        appInitDateTime.month.toString() +
        '-' +
        appInitDateTime.day.toString();
  }

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
                widget.appTitle,
                style: TextStyle(color: Colors.black),
              ),
              background: Center(
                  child: Text(_rubbishGrams.toString() +
                      ' g produced since ' +
                      _appInitDate +
                      '.')),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.restore_page),
                onPressed: _countRubbishGrams,
                tooltip: 'Refresh',
              ),
            ]),
        SliverList(delegate: SliverChildListDelegate(_rubbish)),
      ]),
    );
  }

  void _countRubbishGrams() {
    setState(() {
      _rubbishGrams = 0;

      _rubbish.forEach((item) {
        _rubbishGrams += item.amountInRubbish * item.weightGrams;
        if (_rubbishGrams > _maxRubbishGrams) {
          _rubbishGrams = 0;
        }
      });
    });
  }
}
