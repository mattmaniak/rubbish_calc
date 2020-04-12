import 'package:flutter/material.dart';

Widget showLoadingAnimation() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text('Loading...'),
          ),
        ],
      ),
    );
