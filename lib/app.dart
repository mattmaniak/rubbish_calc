import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'about.dart';
import 'style.dart' as style;
import 'bar.dart';
import 'database.dart';
import 'rubbish.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Db _database = Db();
  final int _maxRubbishGrams = 1000000; // 1 metric ton.
  List<Item> _rubbish = [];
  int _rubbishGrams = 0;
  String _appInitDate = 'never';
  bool _autoRefreshedOnStart = false;

  String get _measuredSinceDatePreloader =>
      'Measured since ' + _appInitDate;

  String get _rubbishGramsPreloader => _rubbishGrams.toString() + ' g';

  String get _currentDate {
    final DateTime measurementStartDateTime = DateTime.now();
    return measurementStartDateTime.year.toString() +
        '-' +
        measurementStartDateTime.month.toString() +
        '-' +
        measurementStartDateTime.day.toString();
  }

  @override
  void initState() {
    super.initState();
    _rubbish = generateRubbish(_maxRubbishGrams, _countRubbishGrams);
    _loadConfig();
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
            backgroundText: _measuredSinceDatePreloader,
            showReturnArrow: false,
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
    SharedPreferences.getInstance().then((preferences) {
      _appInitDate =
          preferences.getString('_appInitDate') ?? _currentDate;
    });
    _database.exists.then((exists) {
      if (exists) {
        _database.read(_rubbish).then((rubbish) {
          _rubbish = rubbish;
          _countRubbishGrams();
        });
      } else {
        _database.create().then((_) {
          _appInitDate = _currentDate;
        });
      }
    });
  }

  void _saveConfig() {
    SharedPreferences.getInstance().then((preferences) {
      preferences.setString('_appInitDate', _appInitDate);
    });
    _database.save(_rubbish);
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
    if ((!_autoRefreshedOnStart) && _rubbish.isNotEmpty) {
      _rubbish.forEach((item) {
        item.update();
      });
      _autoRefreshedOnStart = true;
    }
    _saveConfig();
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
