import 'package:flutter/material.dart';

class Item {
  final int weightGrams;
  final String name;
  Function refreshParentState;
  int id;
  int numberInRubbish = 0;
  String category;

  Item({@required this.name, @required this.weightGrams});
}
