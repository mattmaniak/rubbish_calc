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
  DB _database = DB();

  @override
  void initState() {
    super.initState();
    _rubbish = generateRubbish(_maxRubbishGrams, _countRubbishGrams);
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
    final DateTime measurementStartDateTime = DateTime.now();
    final String currentDate = measurementStartDateTime.year.toString() +
        '-' +
        measurementStartDateTime.month.toString() +
        '-' +
        measurementStartDateTime.day.toString();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _measurementStartDate =
        prefs.getString('_measurementStartDate') ?? currentDate;

    await _database.exists().then((exists) {
      if (exists) {
        _database.read(_rubbish).then((rubbish) {
          _rubbish = rubbish;
        });
      } else {
        _database.create();
        _measurementStartDate = currentDate;
      }
    });
    _countRubbishGrams();
  }

  Future<void> _saveConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('_measurementStartDate', _measurementStartDate);
    _database.save(_rubbish);
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
