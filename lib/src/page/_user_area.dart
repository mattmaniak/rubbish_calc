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
          icon: Icon(
            Icons.add,
            semanticLabel: 'A simple plus.',
          ),
          tooltip: 'Add an item.',
          onPressed: () {},
        ),
        actions: widget.isUserAnonymous
            ? [
                _SignOutButton(
                  onPressed: () => _signOut(context),
                ),
              ]
            : [
                _SignOutButton(
                  onPressed: () => _signOut(context),
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_box,
                    semanticLabel: 'A transparent human silhouette.',
                  ),
                  tooltip: 'Manage your account.',
                  onPressed: _navigateToAccountSettings,
                ),
              ],
      ),
      view: Text(widget.isUserAnonymous ? 'Anonymous user' : 'Email user'),
    );
  }

  void _navigateToAccountSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _AccountSettings(),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    InheritedApp.of(context).switchPage(Visible.loading);
    await InheritedApp.of(context).auth.signOut();
    InheritedApp.of(context).switchPage(Visible.signedOut);
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

class _SignOutButton extends StatelessWidget {
  final Function onPressed;

  const _SignOutButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Transform.rotate(
        angle: pi,
        child: Icon(
          Icons.exit_to_app,
          semanticLabel: 'An arrow with a square border.',
        ),
      ),
      tooltip: 'Sign out',
      onPressed: this.onPressed,
    );
  }
}
