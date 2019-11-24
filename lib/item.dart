import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Item extends StatelessWidget {
  Item({@required this.name, @required this.weightGrams, this.active: false,
        @required this.onChanged});

  int _amountInRubbish = 0;
  final String name;
  final int weightGrams;
  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  int getAmountInRubbish() {
    return _amountInRubbish;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: active ? Colors.lightGreen[700] : Colors.grey[600],
      child: ListTile(
        leading: Icon(
          Icons.restore_from_trash,
          color: Colors.black,
          size: 36.0,
        ),
        title: Text(name),
        trailing: Text(this.weightGrams.toString() + ' grams'),
        onTap: _handleTap,
      ),
    );
  }
}
// https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
// final List<Item> items = [Item(name: 'PET Bottle 0.5 L', weightGrams: 10),
//                           Item(name: 'PET Bottle 1.5 L', weightGrams: 30)];
