part of 'page.dart';

/// The most important page where user can navigate through main app's content.
class UserArea extends StatefulWidget {
  final bool isUserAnonymous;

  const UserArea({this.isUserAnonymous = true});

  @override
  _UserAreaState createState() => _UserAreaState();
}

/// Hold a state of the UserArea.
///
/// Choose between anonymous user UI and email user UI during rendering which
/// are slightly different.
class _UserAreaState extends State<UserArea> {
  @override
  Widget build(BuildContext context) {
    return _ScrollableView(
      bar: _ScrollableBar(
        title: widget.isUserAnonymous ? 'Anonymous user' : 'Email user',
        leading: IconButton(
          icon: Transform.rotate(
            angle: pi,
            child: Icon(
              Icons.exit_to_app,
              semanticLabel: 'An arrow with a square border.',
            ),
          ),
          tooltip: 'Sign out',
          onPressed: () => _signOut(context),
        ),
        actions: !widget.isUserAnonymous
            ? [
                IconButton(
                  icon: Icon(
                    Icons.add_box,
                    semanticLabel: 'A transparent plus.',
                  ),
                  tooltip: 'Add an item.',
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_box,
                    semanticLabel: 'A transparent human silhouette.',
                  ),
                  tooltip: 'Manage your account.',
                  onPressed: () => _navigateToAccountSettings(context),
                ),
              ]
            : null,
      ),
      view: Text(widget.isUserAnonymous ? 'Anonymous user' : 'Email user'),
    );
  }

  void _navigateToAccountSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _AccountSettings(),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingAnimation(),
      ),
    );
    await AppInjector.of(context).auth.signOut();
    AppInjector.of(context).switchPage(Visible.signedOut);
    Navigator.of(context).pop();
  }
}

class _AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<_AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _ScrollableView(
          bar: _ScrollableBar(
            title: 'Account settings',
          ),
          view: ExpansionTile(
            title: Text('Your account'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton(
                      child: Text('Send password reset email'),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text('Remove your account'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
