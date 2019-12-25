import 'package:flutter/material.dart';
import 'url.dart';
import 'bar.dart';
import 'style.dart';

class About extends StatelessWidget {
  static final String _authorURL = 'https://gitlab.com/mattmaniak';
  static final String _repoURL = _authorURL + '/rubbish_calc';
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
          AboutItem(title: 'Created by mattmaniak', url: _authorURL),
          AboutItem(title: 'Source code on GitLab', url: _repoURL),
          AboutItem(title: 'MIT License', url: _licenseURL),
          AboutItem(title: 'Terms of Use', url: _termsURL),
        ])),
      ]),
    );
  }
}

class AboutItem extends StatelessWidget {
  final String title;
  final String url;

  AboutItem({@required this.title, @required this.url});

  Widget build(BuildContext context) {
    return Card(
      color: buttonColor(),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.center,
        ),
        onTap: () => openURL(url),
      ),
    );
  }
}
