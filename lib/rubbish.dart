import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Item extends StatelessWidget{
  Item({this.name, this.weightGrams});

  final String name;
  final int weightGrams;

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
        title: Text(name),
        trailing: Text(this.weightGrams.toString() + ' grams'),
      ),
    );
  }
}
// https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
final List<Item> items = [Item(name: 'PET Bottle 0.5 L', weightGrams: 10),
                          Item(name: 'PET Bottle 1.5 L', weightGrams: 30)];
