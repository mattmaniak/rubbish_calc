import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bar.dart';
import 'error_dialog.dart';
import 'style.dart' as style;

class About extends StatelessWidget {
  static final String _authorURL = 'https://gitlab.com/mattmaniak';
  static final String _repoURL = _authorURL + '/rubbish_calc';
  final String _licenseURL = _repoURL + '/blob/master/LICENSE';
  final String _termsURL = _repoURL + '/blob/master/README.md#terms-of-use';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.backgroundColor,
      body: CustomScrollView(
        slivers: [
          Bar(
            text: 'Rubbish Calc v0.0.0',
            backgroundText: 'About',
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _AboutButton(
                  title: 'Created by mattmaniak',
                  url: _authorURL,
                ),
                _AboutButton(
                  title: 'Source code on GitLab',
                  url: _repoURL,
                ),
                _AboutButton(
                  title: 'MIT License',
                  url: _licenseURL,
                ),
                _AboutButton(
                  title: 'Terms of Use',
                  url: _termsURL,
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
        onTap: () => _openURL(url, context),
      ),
    );
  }

  void _openURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showErrorDialog(
          'Unable to open the link in an external browser.', context);
    }
  }
}
