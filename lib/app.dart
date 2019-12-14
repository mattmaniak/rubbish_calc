import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'info.dart';

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
      backgroundColor: Colors.green[500],
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.green[500],
          pinned: true,
          floating: true,
          expandedHeight: 128.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              _rubbishGrams.toString() + ' g wasted',
              style: TextStyle(color: Colors.black),
            ),
            background: Center(
              child: renderMeasurementStartDate(),
            ),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(_rubbish)),
        SliverList(
            delegate: SliverChildListDelegate([
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            FlatButton(
              child: Text('About'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
              color: Colors.green[100],
            ),
            FlatButton(
              child: Text('License'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => License()),
                );
              },
              color: Colors.green[100],
            ),
            FlatButton(
              child: Text('Terms'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Terms()),
                );
              },
              color: Colors.green[100],
            ),
          ]),
        ])),
      ]),
    );
  }

  Future<void> _loadConfig() async {
    // final DateTime measurementStartDateTime = DateTime.now();
    // final String currentDate = measurementStartDateTime.year.toString() +
    //     '-' +
    //     measurementStartDateTime.month.toString() +
    //     '-' +
    //     measurementStartDateTime.day.toString();

    // String readText;
    // final Directory directory = await getApplicationDocumentsDirectory();
    // final File file = File('${directory.path}/.config');

    final SharedPreferences appConfig = await SharedPreferences.getInstance();
    List<String> amountOfItemsInRubbish = [];

    setState(() {
      _measurementStartDate = appConfig.getString('_measurementStartDate') ??
          DateTime.now().toString();
    });
    try {
      amountOfItemsInRubbish =
          appConfig.getStringList('amountOfItemsInRubbish');

      for (int i = 0; i < _rubbish.length; i++) {
        _rubbish[i].amountInRubbish = int.parse(amountOfItemsInRubbish[i]);
      }
    } catch (exception) {
      return;
    }
    _countRubbishGrams();

    //   readText = await file.readAsString();
    //   debugPrint(readText);
    // } catch (exception) {
    //   readText = DateTime.now().toString();
    //   await file.writeAsString(readText);
    // }
  }

  Future<void> _saveConfig() async {
    // final Directory directory = await getApplicationDocumentsDirectory();
    // final File file = File('${directory.path}/.config');

    final SharedPreferences appConfig = await SharedPreferences.getInstance();
    List<String> amountOfItemsInRubbish = [];

    appConfig.setString('_measurementStartDate', _measurementStartDate);

    for (int i = 0; i < _rubbish.length; i++) {
      amountOfItemsInRubbish.add(_rubbish[i].amountInRubbish.toString());
    }
    appConfig.setStringList('amountOfItemsInRubbish', amountOfItemsInRubbish);
    // if (!await file.exists()) {
    //   await file.writeAsString(_measurementStartDate);
    // }
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
    _saveConfig();
  }

  Text renderMeasurementStartDate() {
    String textToDisplay = 'Loading data...';

    if (_measurementStartDate.toString() != 'null') {
      textToDisplay = 'Measured since ' + _measurementStartDate;
    }
    return Text(
      textToDisplay,
      style: TextStyle(fontSize: 16),
    );
  }
}
