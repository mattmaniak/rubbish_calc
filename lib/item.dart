import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  _ItemState state;

  final int uniqueId;
  final String name;
  final int weightGrams;
  final int maxWeightGrams;
  final Function refreshParentState;
  int numberInRubbish = 0;

  int get weightInRubbishGrams {
    return numberInRubbish * weightGrams;
  }

  Item(
      {@required this.uniqueId,
      @required this.name,
      @required this.weightGrams,
      @required this.maxWeightGrams,
      @required this.refreshParentState});

  @override
  _ItemState createState() {
    _ItemState state = _ItemState();
    return state;
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
      color: Colors.green[100],
      child: ListTile(
          leading: Icon(
            Icons.restore_from_trash,
            color: Colors.black,
            size: 40.0,
          ),
          title: Text(widget.name),
          subtitle: Text(wastedGramsSubtitle),
          trailing: Text(widget.weightGrams.toString() + ' g'),
          onTap: _incrementAmountInRubbish),
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
