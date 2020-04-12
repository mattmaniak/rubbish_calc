import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showDialogBox(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => DialogBox(
      title: title,
      content: content,
    ),
  );
}

class DialogBox extends StatelessWidget {
  final String title;
  final String content;

  const DialogBox({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
