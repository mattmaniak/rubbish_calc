import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'about.dart';
import 'style.dart';
import 'bar.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final int _maxRubbishGrams = 1000000; // 1 metric ton.
  int _rubbishGrams = 0;
  String _measurementStartDate;
  List<Item> _rubbish;

  @override
  void initState() {
    super.initState();

    _rubbish = [
      // https://www.quora.com/How-much-does-a-330ml-can-of-soda-weigh-in-grams
      Item(
        name: 'Aluminium soda can 0.33 L',
        weightGrams: 30,
        refreshParentState: _countRubbishGrams,
      ),
      // https://en.m.wikipedia.org/wiki/Wine_bottle#Environmental_impact
      Item(
        name: 'Glass wine bottle 0.75 L',
        weightGrams: 500,
        refreshParentState: _countRubbishGrams,
      ),
      // https://www.quora.com/How-much-does-a-single-metal-bottle-cap-weigh-from-a-beer-or-soda-bottle
      Item(
        name: 'Metal bottle cap',
        weightGrams: 2,
        refreshParentState: _countRubbishGrams,
      ),
      // https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
      Item(
        name: 'PET Bottle 0.5 L',
        weightGrams: 10,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        name: 'PET Bottle 1.0 L',
        weightGrams: 20,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        name: 'PET Bottle 1.5 L',
        weightGrams: 30,
        refreshParentState: _countRubbishGrams,
      ),
    ];
    _loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(),
      body: CustomScrollView(slivers: <Widget>[
        Bar(
            text: _rubbishGrams.toString() + ' g wasted',
            backgroundText: renderMeasurementStartDate()),
        SliverList(delegate: SliverChildListDelegate(_rubbish)),
        SliverList(
            delegate: SliverChildListDelegate([
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            FlatButton(
              child: Text(
                'About',
                style: TextStyle(color: textColor()),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
              color: buttonColor(),
            ),
          ]),
        ])),
      ]),
    );
  }

  Future<void> _loadConfig() async {
    final DateTime measurementStartDateTime = DateTime.now();
    final String currentDate = measurementStartDateTime.year.toString() +
        '-' +
        measurementStartDateTime.month.toString() +
        '-' +
        measurementStartDateTime.day.toString();

    final SharedPreferences appConfig = await SharedPreferences.getInstance();
    List<String> numberOfItemsInRubbish = [];

    setState(() {
      _measurementStartDate = appConfig.getString('_measurementStartDate') ??
          currentDate;
    });
    try {
      numberOfItemsInRubbish =
          appConfig.getStringList('numberOfItemsInRubbish');
    } catch (exception) {
      // throw 'Unable to load the configuration.';
    }
    for (int i = 0; i < _rubbish.length; i++) {
      try {
      _rubbish[i].numberInRubbish = int.parse(numberOfItemsInRubbish[i]);
      } on FormatException {
        // throw 'Unable to load the configuration.';
      }
    }
    _countRubbishGrams();
  }

  Future<void> _saveConfig() async {
    final SharedPreferences appConfig = await SharedPreferences.getInstance();
    List<String> numberOfItemsInRubbish = [];

    appConfig.setString('_measurementStartDate', _measurementStartDate);

    for (int i = 0; i < _rubbish.length; i++) {
      numberOfItemsInRubbish.add(_rubbish[i].numberInRubbish.toString());
    }
    appConfig.setStringList('numberOfItemsInRubbish', numberOfItemsInRubbish);
  }

  void _countRubbishGrams() {
    setState(() {
      _rubbishGrams = 0;

      _rubbish.forEach((item) {
        _rubbishGrams += item.numberInRubbish * item.weightGrams;
        if (_rubbishGrams > _maxRubbishGrams) {
          _rubbishGrams = 0;
        }
      });
    });
    _saveConfig();
  }

  String renderMeasurementStartDate() {
    if (_measurementStartDate.toString() != 'null') {
      return 'Measured since ' + _measurementStartDate;
    }
    return 'Loading data...';
  }
}
