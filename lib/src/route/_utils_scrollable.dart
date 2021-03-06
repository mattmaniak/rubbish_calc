/// Provide universal visual stuff for various pages.

part of 'route.dart';

/// The universal and preconfigured SliverAppBar.
class _ScrollableBar extends StatelessWidget {
  final List<Widget> actions;
  final String title;
  final Widget leading;

  const _ScrollableBar({@required this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        AppInjector.of(context)?.visibleRoute == Visible.loading;
    return SliverAppBar(
      pinned: true,
      floating: true,
      leading: isLoading ? null : this.leading,
      actions: isLoading ? null : this.actions,
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(isLoading ? 'Loading...' : title),
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

/// The universal and preconfigured SliverScrollView.
class _ScrollableView extends StatelessWidget {
  final Widget bar;
  final Widget floatingActionButton;
  final Widget view;

  const _ScrollableView(
      {@required this.bar, @required this.view, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        AppInjector.of(context)?.visibleRoute == Visible.loading;

    if (isLoading) {
      _hideKeyboard(context);
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          bar,
          SliverList(
            delegate: SliverChildListDelegate(
              isLoading
                  ? [
                      LinearProgressIndicator(
                        semanticsLabel:
                            'An animated line as a loading indicator.',
                      ),
                    ]
                  : [view],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: this.floatingActionButton,
    );
  }

  /// Emulate a tap anywhere and tho, force to hide a keyboard.
  void _hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());
}
