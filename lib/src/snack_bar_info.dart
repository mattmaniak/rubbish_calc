import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

void displaySnackBarInfo(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
    ),
  );
}
