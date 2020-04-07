import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String text;
  final String backgroundText;
  final bool displayReturnArrow;

  const Bar(
      {@required this.text,
      @required this.backgroundText,
      @required this.displayReturnArrow});

  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: _renderReturnArrow(context),
      pinned: true,
      floating: true,
      expandedHeight: 128.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(text),
        background: Center(
          child: Text(backgroundText),
        ),
      ),
    );
  }

  Widget _renderReturnArrow(BuildContext context) {
    if (displayReturnArrow) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    }
    return Text('');
  }
}
