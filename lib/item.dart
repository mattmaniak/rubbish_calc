import 'package:flutter/material.dart';

import 'snack_bar_info.dart';
import 'style.dart' as style;

class Item extends StatefulWidget {
  final String name;
  final int weightGrams;
  int id;
  Function refreshParentState;
  int numberInRubbish = 0;
  _ItemState _state;

  int get weightInRubbishGrams => numberInRubbish * weightGrams;

  Item({@required this.name, @required this.weightGrams});

  @override
  _ItemState createState() {
    _state = _ItemState();
    return _state;
  }

  void update() {
    if (_state != null) {
      _state.update();
    }
  }
}

class _ItemState extends State<Item> {
  static const int _maxWeightGrams = 1000000; // 1 metric ton.

  String get _wastedGramsSubtitle =>
      widget.numberInRubbish.toString() +
      ' wasted - ' +
      widget.weightInRubbishGrams.toString() +
      ' g';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: style.foregroundColor,
      child: ListTile(
        leading: Icon(
          Icons.restore_from_trash,
          color: style.textColor,
          size: 40.0,
        ),
        title: Text(widget.name),
        subtitle: Text(_wastedGramsSubtitle),
        trailing: Text(widget.weightGrams.toString() + ' g'),
        onTap: _incrementAmountInRubbish,
      ),
    );
  }

  void _incrementAmountInRubbish() {
    setState(() {
      if ((++widget.numberInRubbish * widget.weightGrams) > _maxWeightGrams) {
        displaySnackBarInfo(
            context,
            'Cannot waste more than ' +
                _maxWeightGrams.toString() +
                ' g for a single item.');
        widget.numberInRubbish--;
      }
      widget.refreshParentState();
    });
  }

  void update() {
    if (mounted) {
      setState(() {});
    }
  }
}
