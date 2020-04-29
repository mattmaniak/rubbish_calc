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
    final bool isLoading = AppInjector.of(context).isLoading;
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

class _ScrollableView extends StatelessWidget {
  final Widget bar;
  final Widget floatingActionButton;
  final Widget view;

  const _ScrollableView(
      {@required this.bar, @required this.view, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = AppInjector.of(context).isLoading;

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

  /// Force to hide an expanded keyboard.
  void _hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());
}
