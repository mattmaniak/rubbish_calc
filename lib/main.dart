import 'package:flutter/material.dart';

import 'src/app.dart';

void main() {
  runApp(
    RootWidget(
      child: App(),
    ),
  );
}

class RootWidget extends StatelessWidget {
  final Widget child;

  const RootWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rubbish Calc',
      home: SafeArea(
        child: this.child,
      ),
    );
  }
}
