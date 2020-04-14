part of page;

class UserArea extends StatefulWidget {
  @override
  _UserAreaState createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> with _PageTemplateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _displayAppBar(
        titleSufix: 'signed in',
      ),
      body: ListView(
        children: [
          Container(
            height: 100.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
