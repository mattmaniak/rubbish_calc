import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'about.dart';
import 'style.dart';
import 'bar.dart';
import 'database.dart';

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
      Item(
        idInDatabaseTable: 0,
        name: 'Plastic bottle cap',
        weightGrams: 1,
        refreshParentState: _countRubbishGrams,
      ),
      // https://www.quora.com/How-much-does-a-single-metal-bottle-cap-weigh-from-a-beer-or-soda-bottle
      Item(
        idInDatabaseTable: 1,
        name: 'Metal bottle cap',
        weightGrams: 2,
        refreshParentState: _countRubbishGrams,
      ),
      // https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
      Item(
        idInDatabaseTable: 2,
        name: 'PET Bottle 0.5 L',
        weightGrams: 10,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        idInDatabaseTable: 3,
        name: 'PET Bottle 1.0 L',
        weightGrams: 20,
        refreshParentState: _countRubbishGrams,
      ),
      // https://www.quora.com/How-much-does-a-330ml-can-of-soda-weigh-in-grams
      Item(
        idInDatabaseTable: 3,
        name: 'Aluminium soda can 0.33 L',
        weightGrams: 30,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        idInDatabaseTable: 4,
        name: 'PET Bottle 1.5 L',
        weightGrams: 30,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        idInDatabaseTable: 5,
        name: 'Juicebox 1.5 L',
        weightGrams: 45,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        idInDatabaseTable: 6,
        name: 'Juicebox 2 L',
        weightGrams: 60,
        refreshParentState: _countRubbishGrams,
      ),
      // https://en.m.wikipedia.org/wiki/Wine_bottle#Environmental_impact
      Item(
        idInDatabaseTable: 7,
        name: 'Glass wine bottle 0.75 L',
        weightGrams: 500,
        refreshParentState: _countRubbishGrams,
      ),
      Item(
        idInDatabaseTable: 8,
        name: 'Juicebox 1.0 L',
        weightGrams: 30,
        refreshParentState: _countRubbishGrams,
      ),
    ];
    _rubbish.sort((a, b) => a.weightGrams.compareTo(b.weightGrams));
    _loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(),
      body: CustomScrollView(slivers: [
        Bar(
            text: _rubbishGrams.toString() + ' g wasted',
            backgroundText: _renderMeasurementStartDate()),
        SliverList(delegate: SliverChildListDelegate(_rubbish)),
        SliverList(
            delegate: SliverChildListDelegate([
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            FlatButton(
              child: Text(
                'About',
                style: TextStyle(color: textColor()),
              ),
              onPressed: _navigateToAboutScreen,
              color: buttonColor(),
            ),
          ]),
        ])),
      ]),
    );
  }

  Future<void> _loadConfig() async {
    DB database = DB();
    final DateTime measurementStartDateTime = DateTime.now();
    final String currentDate = measurementStartDateTime.year.toString() +
        '-' +
        measurementStartDateTime.month.toString() +
        '-' +
        measurementStartDateTime.day.toString();

    final SharedPreferences appConfig = await SharedPreferences.getInstance();
    List<String> numberOfItemsInRubbish = [];

    _measurementStartDate =
        appConfig.getString('_measurementStartDate') ?? currentDate;
    try {
      numberOfItemsInRubbish =
          appConfig.getStringList('numberOfItemsInRubbish');
    } catch (exception) {
      numberOfItemsInRubbish = List<String>.filled(_rubbish.length, '0');
      _measurementStartDate = currentDate;
    }
    await database.exists().then((exists) {
      if (exists) {
        database.read();
      } else {
        database.create();
      }
    });
    // for (int i = 0; i < _rubbish.length; i++) {
    //   _rubbish[i].numberInRubbish =
    //       int.tryParse(numberOfItemsInRubbish[i]) ?? 0;
    // }
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

  String _renderMeasurementStartDate() {
    if (_measurementStartDate.toString() == 'null') {
      return 'Loading data...';
    }
    return 'Measured since ' + _measurementStartDate;
  }

  void _navigateToAboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => About()),
    );
  }
}
