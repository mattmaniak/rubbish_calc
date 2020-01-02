import 'package:flutter/material.dart';
import 'style.dart' as style;

class Item extends StatefulWidget {
  final int uniqueId;
  final String name;
  final int weightGrams;
  final int maxWeightGrams;
  final Function refreshParentState;
  int numberInRubbish = 0;
  _ItemState _state;

  int get weightInRubbishGrams => numberInRubbish * weightGrams;

  Item(
      {@required this.uniqueId,
      @required this.name,
      @required this.weightGrams,
      @required this.maxWeightGrams,
      @required this.refreshParentState});

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
  String get wastedGramsSubtitle {
    return widget.numberInRubbish.toString() +
        ' wasted - ' +
        widget.weightInRubbishGrams.toString() +
        ' g';
  }

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
        subtitle: Text(wastedGramsSubtitle),
        trailing: Text(widget.weightGrams.toString() + ' g'),
        onTap: _incrementAmountInRubbish,
      ),
    );
  }

  void _incrementAmountInRubbish() {
    setState(() {
      if ((++widget.numberInRubbish * widget.weightGrams) >
          widget.maxWeightGrams) {
        widget.numberInRubbish--;
      }
      widget.refreshParentState();
    });
  }

  void update() {
    setState(() {});
  }
}
