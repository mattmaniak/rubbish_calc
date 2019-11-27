import 'package:flutter/material.dart';

class CalcDisplay extends StatelessWidget {
  CalcDisplay({this.rubbishGrams, this.rubbishCreationDateTime});

  final int rubbishGrams;
  final DateTime rubbishCreationDateTime;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.green,
        height: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
              this.rubbishGrams.toString() +
                  ' grams produced since\n' +
                  this.rubbishCreationDateTime.toString() +
                  '.',
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
