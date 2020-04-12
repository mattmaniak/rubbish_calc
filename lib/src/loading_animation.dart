import 'package:flutter/material.dart';

Widget showLoadingAnimation() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            semanticsLabel: 'Animated circle as a loading indicator',
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text('Loading...'),
          ),
        ],
      ),
    );
