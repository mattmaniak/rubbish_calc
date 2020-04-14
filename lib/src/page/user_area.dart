part of page;

class UserArea extends StatefulWidget {
  final bool isUserAnonymous;

  const UserArea({this.isUserAnonymous = true});

  @override
  _UserAreaState createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> with _PageTemplateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _displayAppBar(
        titleSufix: widget.isUserAnonymous ? 'anonymous user' : 'email user',
      ),
      body: ListView(
        children: [
          Text(widget.isUserAnonymous ? 'Anonymous user' : 'Email user'),
        ],
      ),
      floatingActionButton: widget.isUserAnonymous
          ? null
          : FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add'),
              tooltip: 'Add an item.',
              onPressed: () {},
            ),
    );
  }
}
