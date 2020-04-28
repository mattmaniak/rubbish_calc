part of 'route.dart';

/// Display a common animation to sweeten an user's time when connecting.
class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _hideKeyboard(context);

    return _ScrollableView(
      bar: _ScrollableBar(
        title: 'Loading...',
      ),
      view: LinearProgressIndicator(
        semanticsLabel: 'An animated line as a loading indicator.',
      ),
    );
  }

  /// Force to hide an expanded keyboard.
  void _hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());
}
