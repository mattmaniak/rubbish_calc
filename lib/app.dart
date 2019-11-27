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

  List<Item> _rubbish;

  @override
  void initState() {
    super.initState();

    _rubbish = [
      Item(
        name: 'PET Bottle 0.5 L',
        weightGrams: 10,
      ),
      Item(
        name: 'PET Bottle 1.5 L',
        weightGrams: 30,
      )
    ];
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
              'Rubbish Calc',
              style: TextStyle(color: Colors.black),
            ),
            background:
                Center(child: Text(_countRubbishGrams().toString() + ' g')),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(_rubbish)),
      ]),
    );
  }

  int _countRubbishGrams() {
    int rubbishGrams = 0;

    _rubbish.forEach((item) {
      rubbishGrams += item.amountInRubbish * item.weightGrams;
      if (rubbishGrams > _maxRubbishGrams) {
        // Error.
        return 0;
      }
    });
    return rubbishGrams;
  }
}
