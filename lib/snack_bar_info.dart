import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'style.dart' as style;

void displaySnackBarInfo(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: style.foregroundColor,
        ),
      ),
      backgroundColor: style.backgroundColor,
      duration: Duration(seconds: 5),
    ),
  );
}
