import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'about.dart';
import 'style.dart';
import 'bar.dart';
import 'database.dart';
import 'rubbish.dart';

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
    _rubbish = generateRubbish(_countRubbishGrams);
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
        database.read(_rubbish).then((rubbish) {
          _rubbish = rubbish;
        });
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
    DB database = DB();

    appConfig.setString('_measurementStartDate', _measurementStartDate);

    // for (int i = 0; i < _rubbish.length; i++) {
    //   numberOfItemsInRubbish.add(_rubbish[i].numberInRubbish.toString());
    // }
    // appConfig.setStringList('numberOfItemsInRubbish', numberOfItemsInRubbish);

    database.save(_rubbish);
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
