part of '../page.dart';

/// Display a common animation to sweeten an user's time when connecting.
class LoadingAnimation extends StatelessWidget with _PageTemplateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _displayAppBar(
        titleSufix: 'loading...',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              semanticsLabel:
                  'Animated rotating circle as a loading indicator.',
            ),
          ],
        ),
      ),
    );
  }
}
