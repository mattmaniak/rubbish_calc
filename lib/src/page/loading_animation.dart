part of page;

class LoadingAnimation extends StatelessWidget with _PageTemplateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _displayAppBar(
        titleSufix: 'connecting...',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              semanticsLabel: 'Animated circle as a loading indicator.',
            ),
          ],
        ),
      ),
    );
  }
}
