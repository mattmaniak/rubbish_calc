part of 'page.dart';

/// The most important page where user can navigate through main app's content.
class UserArea extends StatefulWidget {
  final bool isUserAnonymous;
  final Function signOut;
  final Function switchPage;

  const UserArea(
      {@required this.switchPage,
      @required this.signOut,
      this.isUserAnonymous = true});

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
              semanticLabel: 'Sign out',
            ),
          ),
          tooltip: 'Sign out',
          onPressed: _signOut,
        ),
        actions: widget.isUserAnonymous
            ? null
            : [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    semanticLabel: 'Add an item.',
                  ),
                  tooltip: 'Add an item.',
                  onPressed: () {},
                ),
              ],
      ),
      view: Text(widget.isUserAnonymous ? 'Anonymous user' : 'Email user'),
    );
  }

  void _signOut() async {
    widget.switchPage(Visible.loading);
    await widget.signOut();
    widget.switchPage(Visible.signedOut);
  }
}
