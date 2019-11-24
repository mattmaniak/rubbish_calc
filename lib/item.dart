import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  Item({@required this.onChanged, @required this.name,
        @required this.weightGrams, this.amountInRubbish: 0});

  final String name;
  final int weightGrams;
  final ValueChanged<int> onChanged;
  int amountInRubbish = 0;

  void _handleTap() {
    onChanged(++amountInRubbish);
  }

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
        subtitle: Text(
          amountInRubbish.toString()
          + ' thrown equals to '
          + (amountInRubbish * weightGrams).toString()
          + ' g'
        ),
        trailing: Text(this.weightGrams.toString() + ' g'),
        onTap: _handleTap,
      ),
    );
  }
}
// https://www.quora.com/What-is-the-weight-of-1-5-liter-empty-pet-bottles
// final List<Item> items = [Item(name: 'PET Bottle 0.5 L', weightGrams: 10),
//                           Item(name: 'PET Bottle 1.5 L', weightGrams: 30)];
