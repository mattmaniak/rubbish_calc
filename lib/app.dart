import 'package:flutter/material.dart';

import 'about.dart';
import 'bar.dart';
import 'database.dart';
import 'item.dart';
import 'rubbish.dart';
import 'style.dart' as style;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _maxRubbishGrams = 1000000; // 1 metric ton.
  final Db _database = Db();
  List<Item> _rubbish = [];
  int _rubbishGrams = 0;
  String _appInitDate = 'never';
  bool _autoRefreshedOnStart = false;

  @override
  void initState() {
    super.initState();
    _rubbish = generateRubbish(_maxRubbishGrams, _countRubbishGrams);
    _loadConfig();
  }

  String get _appInitDatePreloader => 'Since ' + _appInitDate;
  String get _rubbishGramsPreloader => _rubbishGrams.toString() + ' g overall';

  String get _currentDate {
    final DateTime measurementStartDateTime = DateTime.now();
    return measurementStartDateTime.year.toString() +
        '-' +
        measurementStartDateTime.month.toString() +
        '-' +
        measurementStartDateTime.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    _rubbish.sort((a, b) => a.weightGrams.compareTo(b.weightGrams));

    return Scaffold(
      backgroundColor: style.backgroundColor,
      body: CustomScrollView(
        slivers: [
          Bar(
            text: _rubbishGramsPreloader,
            backgroundText: _appInitDatePreloader,
            displayReturnArrow: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(_rubbish),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text(
                        'About',
                        style: TextStyle(
                          color: style.textColor,
                        ),
                      ),
                      onPressed: _navigateToAboutScreen,
                      color: style.foregroundColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadConfig() {
    _database.exists.then((exists) {
      if (exists) {
        _database.loadRubbish(_rubbish).then((rubbish) {
          _rubbish = rubbish;

          _database.loadAppInitDate(_appInitDate, _currentDate).then((date) {
            _appInitDate = date;
            _countRubbishGrams();
          });
        });
      } else {
        _database.create().then((_) {
          _appInitDate = _currentDate;
        });
      }
    });
  }

  void _countRubbishGrams() {
    _rubbishGrams = 0;

    setState(() {
      _rubbish.forEach((item) {
        _rubbishGrams += item.weightInRubbishGrams;
        if (_rubbishGrams > _maxRubbishGrams) {
          _rubbishGrams = _maxRubbishGrams;
        }
      });
    });
    if (_rubbish.isNotEmpty && (!_autoRefreshedOnStart)) {
      _rubbish.forEach((item) {
        item.update();
      });
      _autoRefreshedOnStart = true;
    }
    _database.save(_rubbish, _appInitDate);
  }

  void _navigateToAboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => About(),
      ),
    );
  }
}
