part of '../page.dart';

/// Display a common animation to sweeten an user's time when connecting.
class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _ScrollableAppBar(title: 'Loading...'),
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
