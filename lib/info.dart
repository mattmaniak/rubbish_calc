import 'package:flutter/material.dart';

abstract class Info extends StatelessWidget {}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('About'),
    );
  }
}

class License extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'https://gitlab.com/mattmaniak/rubbish_calc/blob/master/LICENSE'),
    );
  }
}

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Terms of service'),
    );
  }
}
