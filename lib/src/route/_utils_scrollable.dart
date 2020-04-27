part of 'route.dart';

/// Provide universal visual stuff for various pages.
///
/// As all pages have unifed layout, e.g. bar, this mixin extends all pages
/// to provide an easy-to-programm and common user interface.

class _ScrollableBar extends StatelessWidget {
  final List<Widget> actions;
  final String title;
  final Widget leading;

  const _ScrollableBar({@required this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      leading: this.leading,
      actions: this.actions,
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

class _ScrollableView extends StatelessWidget {
  final Widget bar;
  final Widget view;

  const _ScrollableView({@required this.bar, @required this.view});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        bar,
        SliverList(
          delegate: SliverChildListDelegate(
            [view],
          ),
        ),
      ],
    );
  }
}
