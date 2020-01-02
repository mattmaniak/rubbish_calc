import 'package:flutter/material.dart';
import 'style.dart' as style;

class Bar extends StatelessWidget {
  final String text;
  final String backgroundText;

  Bar({@required this.text, @required this.backgroundText});

  Widget build(BuildContext buildContext) {
    return SliverAppBar(
      backgroundColor: style.backgroundColor,
      pinned: true,
      floating: true,
      expandedHeight: 128.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          text,
          style: TextStyle(
            color: style.textColor,
          ),
        ),
        background: Center(
          child: Text(backgroundText),
        ),
      ),
    );
  }
}
