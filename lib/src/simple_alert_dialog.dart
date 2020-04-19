import 'package:flutter/material.dart';

/// The unified wrapper for the AlertDialog.
class SimpleAlertDialog extends StatelessWidget {
  final String content;
  final String title;

  const SimpleAlertDialog({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
