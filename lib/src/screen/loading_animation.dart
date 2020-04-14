part of screen;

Widget showLoadingAnimation() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            semanticsLabel: 'Animated circle as a loading indicator',
          ),
        ],
      ),
    );
