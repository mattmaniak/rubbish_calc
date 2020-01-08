import 'package:flutter/material.dart';

import 'snack_bar_info.dart';
import 'style.dart' as style;

class Item extends StatefulWidget {
  _ItemState _state;
  final String name;
  final int weightGrams;
  int uniqueId;
  int maxWeightGrams;
  Function refreshParentState;
  int numberInRubbish = 0;

  Item({@required this.name, @required this.weightGrams});

  int get weightInRubbishGrams => numberInRubbish * weightGrams;

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
      if ((++widget.numberInRubbish * widget.weightGrams) >
          widget.maxWeightGrams) {
        displaySnackBarInfo(
            context,
            'Cannot waste more than ' +
                widget.maxWeightGrams.toString() +
                ' g for a single item.');
        widget.numberInRubbish--;
      }
      widget.refreshParentState();
    });
  }

  void update() {
    if (this.mounted) {
      setState(() {});
    }
  }
}
