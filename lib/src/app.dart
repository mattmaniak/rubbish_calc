import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/about.dart';
import 'package:rubbish_calc/src/bar.dart';
import 'package:rubbish_calc/src/item.dart';
import 'package:rubbish_calc/src/rubbish.dart';
import 'package:rubbish_calc/src/login_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _rubbishGrams = 0;
  List<Widget> _items;
  List<Item> _rubbish = generateRubbish();
  String _appInitDate = 'never';

  String get _appInitDatePreloader => 'Since ' + _appInitDate;
  String get _rubbishGramsPreloader => _rubbishGrams.toString() + ' g overall';

  // String get _currentDate {
  //   final DateTime measurementStartDateTime = DateTime.now();
  //   return measurementStartDateTime.year.toString() +
  //       '-' +
  //       measurementStartDateTime.month.toString() +
  //       '-' +
  //       measurementStartDateTime.day.toString();
  // }

  void initState() {
    super.initState();
    _rubbish.sort((a, b) => a.weightGrams.compareTo(b.weightGrams));
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
  // _items = _rubbish
  //     .map(
  //       (item) => Card(
  //         child: ListTile(
  //             leading: Icon(
  //               Icons.restore_from_trash,
  //               size: 40.0,
  //             ),
  //             title: Text(item.name),
  //             subtitle: Text(item.numberInRubbish.toString() +
  //                 ' wasted - ' +
  //                 (item.numberInRubbish * item.weightGrams).toString() +
  //                 ' g'),
  //             trailing: Text(item.weightGrams.toString() + ' g'),
  //             onTap: () => _countRubbishGrams(item)),
  //       ),
  //     )
  //     .toList();

  //   return Scaffold(
  //     body: CustomScrollView(
  //       slivers: [
  //         Bar(
  //           text: _rubbishGramsPreloader,
  //           backgroundText: _appInitDatePreloader,
  //           displayReturnArrow: false,
  //         ),
  //         SliverList(
  //           delegate: SliverChildListDelegate(_items),
  //         ),
  //         SliverList(
  //           delegate: SliverChildListDelegate(
  //             [
  //               ButtonBar(
  //                 alignment: MainAxisAlignment.center,
  //                 children: [
  //                   FlatButton(
  //                     child: Text('About'),
  //                     onPressed: _navigateToAboutScreen,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _countRubbishGrams(Item item) {
  //   setState(() {
  //     item.numberInRubbish++;
  //     _rubbishGrams += item.weightGrams;
  //   });
  // }

  // void _navigateToAboutScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => About(),
  //     ),
  //   );
  // }
}
