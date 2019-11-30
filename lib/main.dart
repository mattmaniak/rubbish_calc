import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  const String materialAppTitle = 'Rubbish Calc';

  runApp(
    MaterialApp(
      title: materialAppTitle,
      home: App(appTitle: materialAppTitle),
    ),
  );
}
