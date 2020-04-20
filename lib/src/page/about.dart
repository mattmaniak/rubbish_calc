part of page;

/// Display info about a current version of the app.
class About extends StatelessWidget with _PageTemplateMixin {
  static const String _authorName = 'mattmaniak';
  static const String _authorURL = 'https://gitlab.com/$_authorName';
  static const String _repoURL = '$_authorURL/rubbish_calc';
  // static const String _semanticVersion = '1.0.0-dev';
  final String _changelogURL = '$_repoURL/blob/master/CHANGELOG.md';
  final String _licenseURL = '$_repoURL/blob/master/LICENSE';
  final String _policyURL = '$_repoURL/blob/master/README.md#privacy-policy';
  final String _termsURL = '$_repoURL/blob/master/README.md#terms-of-use';

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _displayAppBar(
            title: 'About',
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _AboutButton(
                  title: 'Created by $_authorName',
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

/// A specific button that enables URL opening.
class _AboutButton extends StatelessWidget {
  final String title;
  final String url;

  const _AboutButton({@required this.title, @required this.url});

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () => _openURL(context),
      ),
    );
  }

  /// Launch an external browser and open a specified link.
  void _openURL(BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showSimpleAlertDialog(context, 'Something broke...',
          'Unable to open the link in a web browser.');
    }
  }
}
