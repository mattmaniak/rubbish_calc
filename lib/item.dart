import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final String name;
  final int weightGrams;
  Function refreshParentState;
  int numberInRubbish = 0;

  Item(
      {@required this.name,
      @required this.weightGrams,
      @required this.refreshParentState});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
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
          subtitle: Text(widget.numberInRubbish.toString() +
              ' wasted - ' +
              (widget.numberInRubbish * widget.weightGrams).toString() +
              ' g'),
          trailing: Text(widget.weightGrams.toString() + ' g'),
          onTap: _incrementAmountInRubbish),
    );
  }

  void _incrementAmountInRubbish() {
    setState(() {
      widget.numberInRubbish++;
      widget.refreshParentState();
    });
  }
}
