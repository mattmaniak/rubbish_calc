import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'bar.dart';
import 'error_dialog.dart';
import 'style.dart' as style;

class About extends StatelessWidget {
  static const String _semanticVersion = '0.1.0';
  static const String _authorName = 'mattmaniak';
  static const String _authorURL = 'https://gitlab.com/' + _authorName;
  static const String _changelogURL = _repoURL + '/blob/master/CHANGELOG.md';
  static const String _licenseURL = _repoURL + '/blob/master/LICENSE';
  static const String _policyURL =
      _repoURL + '/blob/master/README.md#privacy-policy';
  static const String _repoURL = _authorURL + '/rubbish_calc';
  static const String _termsURL =
      _repoURL + '/blob/master/README.md#terms-of-use';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.backgroundColor,
      body: CustomScrollView(
        slivers: [
          Bar(
            text: 'Rubbish Calc ' + _semanticVersion,
            backgroundText: 'About',
            displayReturnArrow: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Image.asset('assets/icon_transparent.png'),
                _AboutButton(
                  title: 'Created by ' + _authorName,
                  url: _authorURL,
                ),
                _AboutButton(
                  title: 'Source code on GitLab',
                  url: _repoURL,
                ),
                _AboutButton(
                  title: 'Changelog',
                  url: _changelogURL,
                ),
                _AboutButton(
                  title: 'MIT License',
                  url: _licenseURL,
                ),
                _AboutButton(
                  title: 'Terms of Use',
                  url: _termsURL,
                ),
                _AboutButton(
                  title: 'Privacy Policy',
                  url: _policyURL,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutButton extends StatelessWidget {
  final String title;
  final String url;

  _AboutButton({@required this.title, @required this.url});

  Widget build(BuildContext context) {
    return Card(
      color: style.foregroundColor,
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: style.linkColor,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () => _openURL(context),
      ),
    );
  }

  void _openURL(BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showErrorDialog(context, 'Unable to open the link in a web browser.');
    }
  }
}
