import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String text;

  Info({@required this.text});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'About',
        ),
      ),
    );
  }
}

class License extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'MIT License',
        ),
      ),
    );
  }
}

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'For educational purposes only.',
        ),
      ),
    );
  }
}
