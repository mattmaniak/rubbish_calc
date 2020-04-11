import 'package:flutter/material.dart';

class Item {
  final int weightGrams;
  final String name;
  int id;
  int numberInRubbish = 0;

  Item({@required this.name, @required this.weightGrams});
}
