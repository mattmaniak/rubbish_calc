import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final int uniqueId;
  final String name;
  final int weightGrams;
  final int maxWeightGrams;
  final Function refreshParentState;
  int numberInRubbish = 0;

  Item(
      {@required this.uniqueId,
      @required this.name,
      @required this.weightGrams,
      @required this.maxWeightGrams,
      @required this.refreshParentState});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int get weightInRubbishGrams {
    return widget.numberInRubbish * widget.weightGrams;
  }

  String get wastedSubtitle {
    return widget.numberInRubbish.toString() +
        ' wasted - ' +
        weightInRubbishGrams.toString() +
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
          subtitle: Text(wastedSubtitle),
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
}
