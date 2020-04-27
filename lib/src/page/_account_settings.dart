part of 'page.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _ScrollableView(
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
                      child: Text('Send password reset email'),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text('Delete your account'),
                      onPressed: () => _deleteAccount(context),
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

  void _deleteAccount(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingAnimation(),
      ),
    );
    await AppInjector.of(context).auth.deleteAccount();
    AppInjector.of(context).switchPage(Visible.signedOut);
    Navigator.of(context).pop();
  }

  void _navigateBack(BuildContext context) =>
      AppInjector.of(context).switchPage(Visible.signedIn);
}
