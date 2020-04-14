part of page;

class UserArea extends StatefulWidget {
  @override
  _UserAreaState createState() => _UserAreaState();
}

class _UserAreaState extends State<UserArea> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100.0,
          color: Colors.black,
        ),
      ],
    );
  }
}
