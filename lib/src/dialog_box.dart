import 'package:flutter/material.dart';

void showDialogBox(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => _DialogBox(
      title: title ?? 'Something broke...',
      content: content ?? 'Unknown error.',
    ),
  );
}

class _DialogBox extends StatelessWidget {
  final String content;
  final String title;

  const _DialogBox({@required this.title, @required this.content});

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
