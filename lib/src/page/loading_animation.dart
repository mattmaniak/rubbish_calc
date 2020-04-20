part of page;

/// Display a common animation to sweeten an user's time when connecting.
class LoadingAnimation extends StatelessWidget with _PageTemplateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _displayAppBar(title: 'Loading...'),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CircularProgressIndicator(
                  semanticsLabel:
                      'Animated rotating circle as a loading indicator.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
