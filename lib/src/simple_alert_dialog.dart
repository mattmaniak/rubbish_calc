import 'package:flutter/material.dart';

/// The highly simplified AlertDialog renderer.
void showSimpleAlertDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => _SimpleAlertDialog(
      title: title ?? 'Something broke...',
      content: content ?? 'Unknown error.',
    ),
  );
}

/// The unified wrapper for the AlertDialog.
class _SimpleAlertDialog extends StatelessWidget {
  final String content;
  final String title;

  const _SimpleAlertDialog({@required this.title, @required this.content});

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
