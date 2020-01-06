import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'style.dart' as style;

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ErrorDialog(message: message),
  );
}

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: style.errorColor,
      title: Text('Something broke...'),
      content: Text(message),
      actions: [
        FlatButton(
          color: style.foregroundColor,
          child: Text(
            'Ok',
            style: TextStyle(
              color: style.textColor,
            ),
          ),
          onPressed: () => _close(context),
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
