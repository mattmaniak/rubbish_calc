part of 'route.dart';

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
                    Icons.account_box,
                    semanticLabel: 'A transparent human silhouette.',
                  ),
                  tooltip: 'Manage your account',
                  onPressed: () => _navigateToAccountSettings(context),
                ),
              ]
            : null,
      ),
      view: Text(widget.isUserAnonymous ? 'Anonymous user' : 'Email user'),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add_box,
          semanticLabel: 'A transparent plus.',
        ),
        label: Text('Add an item'),
        tooltip: 'Add an item to the database',
        onPressed: () {},
      ),
    );
  }

  void _navigateToAccountSettings(BuildContext context) =>
      AppInjector.of(context).changeRoute(Visible.accountSettings);

  void _signOut(BuildContext context) async {
    AppInjector.of(context).changeRoute(Visible.loading);
    if (widget.isUserAnonymous) {
      await AppInjector.of(context).auth.deleteAccount(); // Prevent anon spam.
    } else {
      await AppInjector.of(context).auth.signOut();
      await SessionStorage.clear();
    }
    AppInjector.of(context).changeRoute(Visible.signedOut);
  }
}
