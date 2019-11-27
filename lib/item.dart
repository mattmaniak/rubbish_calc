import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final String name;
  final int weightGrams;
  int amountInRubbish = 0;

  Item({@required this.name, @required this.weightGrams});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
          leading: Icon(
            Icons.restore_from_trash,
            color: Colors.black,
            size: 36.0,
          ),
          title: Text(widget.name),
          subtitle: Text(widget.amountInRubbish.toString() +
              ' thrown equals to ' +
              (widget.amountInRubbish * widget.weightGrams).toString() +
              ' g'),
          trailing: Text(widget.weightGrams.toString() + ' g'),
          onTap: () => widget.amountInRubbish++),
    );
  }
}
