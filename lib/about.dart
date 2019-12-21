import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bar.dart';
import 'style.dart';

class About extends StatelessWidget {
  static final String _repoURL = 'https://gitlab.com/mattmaniak/rubbish_calc';
  final String _licenseURL = _repoURL + '/blob/master/LICENSE';
  final String _termsURL = _repoURL + '/blob/master/README.md#terms-of-use';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(),
      body: CustomScrollView(slivers: <Widget>[
        Bar(
          text: 'Rubbish Calc v0.0.0',
          backgroundText: 'About',
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Card(
            color: buttonColor(),
            child: ListTile(
              title: Text(
                'Source code',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () => _openURL(_repoURL),
            ),
          ),
          Card(
            color: buttonColor(),
            child: ListTile(
              title: Text(
                'License',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () => _openURL(_licenseURL),
            ),
          ),
          Card(
            color: buttonColor(),
            child: ListTile(
              title: Text(
                'Terms of Use',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () => _openURL(_termsURL),
            ),
          ),
        ])),
      ]),
    );
  }

  void _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to open the license in a browser.';
    }
  }
}
