import 'package:flutter/material.dart';
import 'bar.dart';
import 'style.dart';

class About extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(),
      body: CustomScrollView(slivers: <Widget>[
        Bar(
          text: 'Rubbish Calc v0.0.0',
          backgroundText: 'About app',
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Card(color: buttonColor(), child: Text('License')),
          // Text('Terms of Use')
        ])),
      ]),
    );
  }
}
