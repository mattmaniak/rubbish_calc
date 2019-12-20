import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bar.dart';
import 'style.dart';

class About extends StatelessWidget {
  static final String _repoURL = 'https://gitlab.com/mattmaniak/rubbish_calc';

  final String _licenseURL = _repoURL + '/blob/master/LICENSE';

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
          Card(
            color: buttonColor(),
            child: ListTile(
              leading: Text('Repo'),
              title: Text(
                _repoURL,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: _openLicenseURL,
            ),
          ),
          Card(
            color: buttonColor(),
            child: ListTile(
              leading: Text('License'),
              title: Text(
                _licenseURL,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: _openLicenseURL,
            ),
          ),
          Card(
            color: buttonColor(),
            child: ListTile(
              leading: Text('Terms'),
              title: Text(
                _licenseURL,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: _openLicenseURL,
            ),
          ),
        ])),
      ]),
    );
  }

  void _openLicenseURL() async {
    if (await canLaunch(_licenseURL)) {
      await launch(_licenseURL);
    } else {
      throw 'Unable to open the license in a browser.';
    }
  }
}
