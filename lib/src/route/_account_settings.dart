part of 'route.dart';

/// The place when an user is able to manage his/her account.
class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

/// Current state of the AccountSettings.
class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return _ScrollableView(
      bar: _ScrollableBar(
        title: 'Account settings',
        leading: IconButton(
          tooltip: 'Go back',
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: 'An arrow pointing left.',
          ),
          onPressed: () => _navigateBack(context),
        ),
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
                  child: Text('Reset your password'),
                  onPressed: () => _resetPassword(context),
                ),
                FlatButton(
                  child: Text('Delete the account permanently'),
                  onPressed: () => _deleteAccount(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Delete an user account from a Firebase database.
  void _deleteAccount(BuildContext context) async {
    AppInjector.of(context).changeRoute(Visible.loading);
    await AppInjector.of(context).auth.deleteAccount();
    AppInjector.of(context).changeRoute(Visible.signedOut);
  }

  /// Go back to the UserArea.
  void _navigateBack(BuildContext context) =>
      AppInjector.of(context).changeRoute(Visible.signedIn);

  /// Send a password reset email.
  void _resetPassword(BuildContext context) async =>
      await AppInjector.of(context).auth.resetPassword();
}
