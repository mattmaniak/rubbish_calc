part of '../page.dart';

/// Provide universal visual stuff for various pages.
///
/// As all pages have unifed layout, e.g. appBar, this mixin extends all pages
/// to provide an easy-to-programm and common user interface.

class _ScrollableAppBar extends StatelessWidget {
  final String title;
  final Widget leading;

  const _ScrollableAppBar({@required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: this.leading,
      pinned: true,
      floating: true,
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(title),
        background: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text('Rubbish Calc'),
          ],
        ),
      ),
    );
  }
}

class _ScrollableScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget home;
  final Widget floatingActionButton;

  const _ScrollableScaffold(
      {@required this.appBar, @required this.home, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          appBar,
          SliverList(
            delegate: SliverChildListDelegate(
              [home],
            ),
          ),
        ],
      ),
      floatingActionButton: this.floatingActionButton,
    );
  }
}
