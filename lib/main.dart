import 'package:flutter/material.dart';

import 'package:rubbish_calc/src/app.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rubbish Calc',
      home: SafeArea(
        child: App(),
      ),
    ),
  );
}
