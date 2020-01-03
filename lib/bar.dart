import 'package:flutter/material.dart';
import 'style.dart' as style;

class Bar extends StatelessWidget {
  final String text;
  final String backgroundText;
  final bool showReturnArrow;

  Bar(
      {@required this.text,
      @required this.backgroundText,
      @required this.showReturnArrow});

  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: _renderReturnArrow(context),
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

  Widget _renderReturnArrow(BuildContext context) {
    if (showReturnArrow) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        color: style.foregroundColor,
        onPressed: () => Navigator.pop(context),
      );
    }
    return Text('');
  }
}
