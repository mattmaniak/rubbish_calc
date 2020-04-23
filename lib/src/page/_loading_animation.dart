part of 'page.dart';

/// Display a common animation to sweeten an user's time when connecting.
class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ScrollableView(
      bar: _ScrollableBar(
        title: 'Loading...',
      ),
      view: LinearProgressIndicator(
        semanticsLabel: 'Animated line as a loading indicator.',
      ),
    );
  }
}
