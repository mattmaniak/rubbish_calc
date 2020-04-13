import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/app.dart';

void main() {
  const String title = 'Rubbish Calc';

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: App(
        appName: title,
      ),
    ),
  );
}
